/datum/component/crafting_ingridient
	var/list/simple_recipes = list()
	var/datum/crafting_recipe/current_recipe
	var/current_step = 1

/datum/component/crafting_ingridient/Initialize()
	if(!istype(parent, /obj))
		return COMPONENT_INCOMPATIBLE

	for(var/base_item in GLOB.sorted_crafting_recipes)
		if(istype(parent, base_item))
			for(var/datum/crafting_recipe/recipe as anything in GLOB.sorted_crafting_recipes[base_item])
				if(recipe.simple)
					simple_recipes |= recipe

	if(simple_recipes.len)
		RegisterSignal(parent, COMSIG_PARENT_ATTACKBY, .proc/handle_simple_recipes)

	RegisterSignal(parent, COMSIG_PARENT_EXAMINE, .proc/on_examine)
	RegisterSignal(parent, COMSIG_CRAFTING_RECIPE_START, .proc/_start_recipe)

//Wrapper proc, we cant sleep here
/datum/component/crafting_ingridient/proc/_start_recipe(datum/source, mob/user, datum/crafting_recipe/recipe)
	SIGNAL_HANDLER
	if(recipe.always_available || (recipe in user.mind.learned_recipes))
		if(istype(parent, recipe.base_item))
			INVOKE_ASYNC(src, .proc/start_recipe, user, recipe)

/datum/component/crafting_ingridient/proc/start_recipe(mob/user, datum/crafting_recipe/recipe)
	if(do_after(user, 2 SECONDS, TRUE, parent))
		current_recipe = recipe
		current_step = 1

/datum/component/crafting_ingridient/proc/handle_steps(datum/source, obj/item/item, mob/user, datum/crafting_recipe/recipe)
	SIGNAL_HANDLER
	if(!recipe)
		if(!current_recipe)
			return
		recipe = current_recipe

	if(!recipe.always_available && !(recipe in user.mind.learned_recipes))
		return

	var/list/step_result = recipe.try_step(item, current_step)

	if(!islist(step_result))
		return

	//do_after uses stoplag()
	INVOKE_ASYNC(src, .proc/on_step_success, step_result, item, user, recipe)
	return TRUE

/datum/component/crafting_ingridient/proc/on_step_success(list/step_result, obj/item/item, mob/user, datum/crafting_recipe/recipe)
	switch(step_result[1])
		if(CRAFT_ITEM)
			if(do_after(user, step_result[2], TRUE, parent))
				qdel(item)
				.=TRUE

		if(CRAFT_TOOL)
			if(item.use_tool(parent, user, step_result[2], step_result[3], step_result[4]))
				.=TRUE

		if(CRAFT_CRAFTING_QUALITY)
			if(do_after(user, step_result[2], TRUE, parent))
				qdel(item)
				.=TRUE

		if(CRAFT_REAGENT)
			if(do_after(user, step_result[2], TRUE, parent))
				if(item.reagents.remove_reagent(step_result[3], step_result[4]))
					.=TRUE

		if(CRAFT_MATERIAL)
			if(do_after(user, step_result[2], TRUE, parent))
				var/obj/item/stack/stack = item
				stack.use(step_result[3])
				.=TRUE

	if(.)
		if(current_step < recipe.steps.len)
			current_step += 1
		else
			if(isitem(parent))
				var/obj/item/parent_obj = parent
				var/turf/parent_turf = get_turf(parent_obj)
				if(ispath(recipe.result, /obj/item))
					var/obj/item/result = new recipe.result
					if(parent_obj.loc == user)
						parent_obj.moveToNullspace()
						user.put_in_inactive_hand(result)
					else
						parent_obj.moveToNullspace()
						result.doMove(get_turf(parent_obj))
				else
					parent_obj.moveToNullspace()
					new recipe.result(parent_turf)
			else
				var/obj/parent_obj = parent
				var/turf/parent_turf = get_turf(parent_obj)
				parent_obj.moveToNullspace()
				new recipe.result(parent_turf)
			qdel(parent)

/datum/component/crafting_ingridient/proc/handle_simple_recipes(datum/source, obj/item/item, mob/user)
	SIGNAL_HANDLER
	for(var/datum/crafting_recipe/recipe as anything in simple_recipes)
		if(recipe.always_available || (recipe in user.mind.learned_recipes))
			if(handle_steps(source, item, user, recipe))
				current_recipe = recipe
				UnregisterSignal(parent, COMSIG_PARENT_ATTACKBY)
				RegisterSignal(parent, COMSIG_PARENT_ATTACKBY, .proc/handle_steps)
				break

/datum/component/crafting_ingridient/proc/on_examine(datum/source, mob/user)
	SIGNAL_HANDLER
	if(current_recipe)
		for(var/step_desc in current_recipe.get_examine_text(current_step))
			to_chat(user, step_desc)
