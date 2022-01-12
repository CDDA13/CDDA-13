/datum/component/crafting_ingridient
	var/list/simple_recipes = list()
	var/datum/crafting_recipe/current_recipe
	var/current_step = 1

/datum/component/crafting_ingridient/Initialize()
	if(!istype(parent, /obj))
		return COMPONENT_INCOMPATIBLE

	for(var/path in GLOB.simple_recipes)
		if(istype(parent, path))
			simple_recipes |= GLOB.simple_recipes[path]

	if(simple_recipes.len)
		RegisterSignal(parent, COMSIG_PARENT_ATTACKBY, .proc/handle_simple_recipes)

	RegisterSignal(parent, COMSIG_PARENT_EXAMINE, .proc/on_examine)

/datum/component/crafting_ingridient/proc/start_recipe(datum/crafting_recipe/recipe)
	if(!current_recipe)
		current_recipe = recipe
		current_step = 1
		UnregisterSignal(parent, COMSIG_PARENT_ATTACKBY)
		RegisterSignal(parent, COMSIG_PARENT_ATTACKBY, .proc/handle_steps)

/datum/component/crafting_ingridient/proc/handle_steps(datum/source, obj/item/item, mob/user, params, datum/crafting_recipe/recipe)
	if(!recipe)
		if(!current_recipe)
			return
		recipe = current_recipe

	if(!recipe.always_available && !(recipe in user.mind.learned_recipes))
		return

	var/list/step_result = recipe.try_step(item, current_step)

	if(!islist(step_result))
		return

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

		if(CRAFT_MATERIAL)
			if(do_after(user, step_result[2], TRUE, parent))
				var/obj/item/stack/stack = item
				stack.use(step_result[3])
				.=TRUE

	if(.)
		if(recipe.steps[current_step+1])
			current_step += 1
		else
			if(isitem(parent))
				var/obj/item/parent_obj = parent
				var/turf/parent_turf = get_turf(parent_obj)
				if(ispath(recipe.result, /obj/item))
					var/obj/item/result = new recipe.result
					if(parent_obj.loc == user)
						parent_obj.moveToNullspace()
						user.put_in_hands(result)
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

/datum/component/crafting_ingridient/proc/handle_simple_recipes(datum/source, obj/item/item, mob/user, params)
	for(var/datum/crafting_recipe/recipe in simple_recipes)
		if(handle_steps(source, item, user, params, recipe))
			UnregisterSignal(parent, COMSIG_PARENT_ATTACKBY)
			RegisterSignal(parent, COMSIG_PARENT_ATTACKBY, .proc/handle_steps)
			break

/datum/component/crafting_ingridient/proc/on_examine(datum/source, mob/user)
	to_chat(user, "test test")
