/datum/component/crafting
	var/cur_category = CAT_MISC
	var/list/categories = list(CAT_MISC)
	var/display_craftable_only = FALSE

/datum/component/crafting/Initialize()
	if(ismob(parent))
		for(var/datum/crafting_recipe/recipe in GLOB.always_available_recipes)
			categories |= recipe.category
		var/mob/mob = parent
		RegisterSignal(parent, COMSIG_MOB_LOGIN, .proc/create_mob_button)
		RegisterSignal(mob.mind, COMSIG_ADD_NEW_CATEGORY, .proc/add_new_category)
	else
		return COMPONENT_INCOMPATIBLE

/datum/component/crafting/proc/create_mob_button(mob/user)
	SIGNAL_HANDLER
	var/obj/screen/craft/button = new()
	user.hud_used.static_inventory += button
	user.client.screen += button
	RegisterSignal(button, COMSIG_CLICK, .proc/component_ui_interact)

/datum/component/crafting/proc/add_new_category(mob/user, category)
	categories |= category

/datum/component/crafting/proc/component_ui_interact(obj/screen/craft/image, location, control, params, user)
	SIGNAL_HANDLER

	if(user == parent)
		INVOKE_ASYNC(src, .proc/ui_interact, user)

/datum/component/crafting/ui_state(mob/user)
	return GLOB.not_incapacitated_turf_state

//For the UI related things we're going to assume the user is a mob rather than typesetting it to an atom as the UI isn't generated if the parent is an atom
/datum/component/crafting/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		cur_category = categories[1]
		ui = new(user, src, "PersonalCrafting", "Crafting Menu")
		ui.open()

/datum/component/crafting/ui_assets(mob/user)
	return list(
		get_asset_datum(/datum/asset/spritesheet/crafting_buttons),
		get_asset_datum(/datum/asset/spritesheet/recipe_icons)
		)

/datum/component/crafting/ui_data(mob/user)
	var/list/data = list()
	var/mob/parent_mob = parent

	data["category"] = cur_category
	data["categories"] = categories

	data["_recipes"] = list()
	for(var/datum/crafting_recipe/recipe as anything in parent_mob.mind.learned_recipes)
		if(cur_category == recipe.category)
			data["_recipes"] += list(list(
				"name"=recipe.name,
				"id"=REF(recipe),
				"desc"=recipe.desc,
				"button_icon"=replacetext("[recipe.result]", "/", "_"),
				"steps"=recipe.get_examine_text(1)))

	for(var/datum/crafting_recipe/recipe as anything in GLOB.always_available_recipes)
		if(cur_category == recipe.category)
			data["_recipes"] += list(list(
				"name"=recipe.name,
				"id"=REF(recipe),
				"desc"=recipe.desc,
				"button_icon"=replacetext("[recipe.result]", "/", "_"),
				"steps"=recipe.get_examine_text(1)))

	return data

/datum/component/crafting/ui_static_data(mob/user)
	var/list/data = list()

	return data

/datum/component/crafting/ui_act(action, params)
	. = ..()
	if(.)
		return
	switch(action)
		if("set_category")
			if(params["category"] in categories)
				cur_category = params["category"]
				.=TRUE

		if("start_recipe")
			.=TRUE
