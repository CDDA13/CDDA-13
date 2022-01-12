/datum/crafting_recipe
	var/name
	var/desc
	var/category = CAT_NONE
	var/obj/base_item
	var/obj/result
	var/always_available
	// Each step consists of:
	// 1. Way of crafting
	// 2. Required item/quality
	// 3. Time to complete step
	// 4. Additional arguments:
	//		CRAFT_MATERIAL: Units to use
	//		CRAFT_TOOL: fuel amount (should be 0 if item doesnt consume any), volume
	//		CRAFT_CRAFTING_QUALITY: quality level
	var/list/list/steps
	var/is_simple

/datum/crafting_recipe/New()
	.=..()
	if(is_simple)
		GLOB.simple_recipes[base_item] += src
	if(always_available)
		GLOB.always_available_recipes += src

/datum/crafting_recipe/proc/try_step(obj/item/item, step_stage)
	var/list/step = steps[step_stage]
	switch(step[1])
		if(CRAFT_ITEM)
			if(istype(item, step[2]))
				return list(step[1], step[3])

		if(CRAFT_TOOL)
			if(item.tool_behaviour == step[2])
				return list(step[1], step[3], step[4], step[5])

		if(CRAFT_CRAFTING_QUALITY)
			if(item.crafting_qualities[step[2]] >= step[4])
				return list(step[1], step[3])

		if(CRAFT_MATERIAL)
			if(isitemstack(item))
				var/obj/item/stack/stack = item
				if(stack.amount >= step[4])
					return list(step[1], step[3], step[4])

/datum/crafting_recipe/proc/get_examine_text()

/datum/crafting_recipe/test
	name = "test"
	desc = "very stesty"
	category = CAT_MISC
	base_item = /obj/item/mass_spectrometer
	result = /obj/item/megaphone
	is_simple = TRUE
	always_available = TRUE
	steps = list(
		list(CRAFT_MATERIAL, /obj/item/stack/sheet/glass, 10, 2),
		list(CRAFT_ITEM, /obj/item/defibrillator, 5),
		list(CRAFT_TOOL, TOOL_SCREWDRIVER, 7, 0, 6),
		list(CRAFT_CRAFTING_QUALITY, CRAFTING_QUALITY_STICK, 7, 1),
	)
