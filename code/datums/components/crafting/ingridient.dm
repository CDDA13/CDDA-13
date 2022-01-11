/datum/component/crafting_ingridient
	var/list/simple_recipes = list() // assoc
	var/datum/crafting_recipe/current_recipe
	var/current_step = 1

/datum/component/crafting_ingridient/Initialize()
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

/datum/component/crafting_ingridient/proc/handle_steps(datum/source, obj/item/item, mob/user, params, datum/crafting_recipe/recipe, step)
	if(!recipe)
		if(!current_recipe)
			return
		recipe = current_recipe

	if(!step)
		step = current_step

	var/list/step_result = recipe.try_step(item, step)

	if(!islist(step_result))
		return

/datum/component/crafting_ingridient/proc/handle_simple_recipes(datum/source, obj/item/item, mob/user, params)
	for(var/datum/crafting_recipe/recipe in simple_recipes)
		if(handle_steps(source, item, user, params, recipe))
			UnregisterSignal(parent, COMSIG_PARENT_ATTACKBY)
			RegisterSignal(parent, COMSIG_PARENT_ATTACKBY, .proc/handle_steps)
			break

/datum/component/crafting_ingridient/proc/on_examine(datum/source, mob/user)
	to_chat(user, "test test")
