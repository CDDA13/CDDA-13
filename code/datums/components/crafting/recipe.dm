/datum/crafting_recipe
	// Shouldn't be longer then 24 characters
	var/name
	var/desc
	var/category = CAT_MISC
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
	//		CRAFT_REAGENT: amount of reagents
	var/list/list/steps
	var/simple
	var/hidden

/datum/crafting_recipe/New()
	.=..()
	GLOB.sorted_crafting_recipes[base_item] += list(src)
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

		if(CRAFT_REAGENT)
			if(item.reagents?.has_reagent(step[2], step[4]))
				return list(step[1], step[3], step[2], step[4])

		if(CRAFT_MATERIAL)
			if(isitemstack(item))
				var/obj/item/stack/stack = item
				if(stack.amount >= step[4])
					return list(step[1], step[3], step[4])

/datum/crafting_recipe/proc/get_examine_text(current_step)
	. = list()
	if(!current_step)
		. += list("[capitalize(initial(base_item.name))] is required to start the recipe")
	var/list/steps_to_check = steps.Copy(current_step)
	for(var/step in steps_to_check)
		switch(step[1])
			if(CRAFT_ITEM)
				var/atom/object = step[2]
				. += "Apply [initial(object.name)] to continue"

			if(CRAFT_TOOL)
				. += "Apply tool with [step[2]] quality to continue"

			if(CRAFT_CRAFTING_QUALITY)
				. += "Apply [GLOB.crafting_qualities_names[step[2]][step[4]]] [step[2]] quality to continue"

			if(CRAFT_REAGENT)
				var/datum/reagent/reagent = step[2]
				. += "Apply [step[4]]u of [initial(reagent.name)] to continue"

			if(CRAFT_MATERIAL)
				var/obj/item/stack/stack = step[2]
				. += "Apply [step[4]] [initial(stack.name)] to continue"
