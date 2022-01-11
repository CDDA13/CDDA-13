/datum/component/crafting/Initialize()
	if(ismob(parent))
		RegisterSignal(parent, COMSIG_MOB_LOGIN, .proc/create_mob_button)

/datum/component/crafting/proc/create_mob_button(mob/user, client/CL)
	SIGNAL_HANDLER

	var/datum/hud/H = user.hud_used
	var/obj/screen/craft/C = new()
	H.static_inventory += C
	CL.screen += C
	RegisterSignal(C, COMSIG_CLICK, .proc/component_ui_interact)

/datum/component/crafting
	var/busy
	var/viewing_category = 1 //typical powergamer starting on the Weapons tab
	var/viewing_subcategory = 1

	var/cur_category = CAT_NONE
	var/cur_subcategory = CAT_NONE
	var/list/categories = list()
	var/datum/action/innate/crafting/button
	var/display_craftable_only = FALSE
	var/display_compact = TRUE

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
		ui = new(user, src, "PersonalCrafting")
		ui.open()

/datum/component/crafting/ui_data(mob/user)
	var/list/data = list()

	return data

/datum/component/crafting/ui_static_data(mob/user)
	var/list/data = list()

	return data

/datum/component/crafting/ui_act(action, params)
	. = ..()
	if(.)
		return
	switch(action)
		if("make")

		if("toggle_recipes")

		if("toggle_compact")

		if("set_category")
