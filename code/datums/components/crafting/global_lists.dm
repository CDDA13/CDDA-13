GLOBAL_LIST_INIT(crafting_qualities_names, list(
	CRAFTING_QUALITY_STICK = list(1 = "wooden", 2 = "steel", 3 = "titanium")
))

GLOBAL_LIST_EMPTY(crafting_recipes)

GLOBAL_LIST_EMPTY(sorted_crafting_recipes)

GLOBAL_LIST_EMPTY(always_available_recipes)

GLOBAL_LIST_INIT(iconic_tools, list(
	TOOL_CROWBAR = /obj/item/tool/crowbar,
	TOOL_MULTITOOL = /obj/item/multitool,
	TOOL_SCREWDRIVER = /obj/item/tool/screwdriver,
	TOOL_WIRECUTTER = /obj/item/tool/wirecutters,
	TOOL_WRENCH = /obj/item/tool/wrench,
	TOOL_WELDER = /obj/item/tool/weldingtool,
	TOOL_WELD_CUTTER = /obj/item/tool/pickaxe/plasmacutter,
	//No tools with this quality
	//TOOL_ANALYZER = ,
	//TOOL_MINING = ,
	//TOOL_SHOVEL = ,
	TOOL_FULTON = /obj/item/fulton_extraction_pack))

GLOBAL_LIST_INIT(crafting_qualities_icons, list(
	CRAFTING_QUALITY_STICK = list(
		1 = /obj/item/crafting_component/stick,
		2 = /obj/item/crafting_component/stick/steel,
		3 = /obj/item/crafting_component/stick/titanium)
))
