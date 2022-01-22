//DEFINITIONS FOR ASSET DATUMS START HERE.


/datum/asset/simple/tgui
	keep_local_name = TRUE
	assets = list(
		"tgui.bundle.js" = file("tgui/public/tgui.bundle.js"),
		"tgui.bundle.css" = file("tgui/public/tgui.bundle.css"),
	)

/datum/asset/simple/tgui_panel
	keep_local_name = TRUE
	assets = list(
		"tgui-panel.bundle.js" = file("tgui/public/tgui-panel.bundle.js"),
		"tgui-panel.bundle.css" = file("tgui/public/tgui-panel.bundle.css"),
	)

/datum/asset/simple/inventory
	assets = list(
		"inventory-glasses.png" = 'icons/UI_Icons/inventory/glasses.png',
		"inventory-head.png" = 'icons/UI_Icons/inventory/head.png',
		"inventory-mask.png" = 'icons/UI_Icons/inventory/mask.png',
		"inventory-ears.png" = 'icons/UI_Icons/inventory/ears.png',
		"inventory-uniform.png" = 'icons/UI_Icons/inventory/uniform.png',
		"inventory-suit.png" = 'icons/UI_Icons/inventory/suit.png',
		"inventory-gloves.png" = 'icons/UI_Icons/inventory/gloves.png',
		"inventory-hand_l.png" = 'icons/UI_Icons/inventory/hand_l.png',
		"inventory-hand_r.png" = 'icons/UI_Icons/inventory/hand_r.png',
		"inventory-shoes.png" = 'icons/UI_Icons/inventory/shoes.png',
		"inventory-suit_storage.png" = 'icons/UI_Icons/inventory/suit_storage.png',
		"inventory-belt.png" = 'icons/UI_Icons/inventory/belt.png',
		"inventory-back.png" = 'icons/UI_Icons/inventory/back.png',
		"inventory-pocket.png" = 'icons/UI_Icons/inventory/pocket.png',
	)

/datum/asset/simple/irv
	assets = list(
		"jquery-ui.custom-core-widgit-mouse-sortable-min.js" = 'html/IRV/jquery-ui.custom-core-widgit-mouse-sortable-min.js',
	)

/datum/asset/group/irv
	children = list(
		/datum/asset/simple/jquery,
		/datum/asset/simple/irv,
	)


/datum/asset/simple/jquery
	legacy = TRUE
	assets = list(
		"jquery.min.js" = 'html/jquery.min.js',
	)

/datum/asset/simple/namespaced/fontawesome
	legacy = TRUE //remove on tgui4
	assets = list(
		"fa-regular-400.eot"  = 'html/font-awesome/webfonts/fa-regular-400.eot',
		"fa-regular-400.woff" = 'html/font-awesome/webfonts/fa-regular-400.woff',
		"fa-solid-900.eot"    = 'html/font-awesome/webfonts/fa-solid-900.eot',
		"fa-solid-900.woff"   = 'html/font-awesome/webfonts/fa-solid-900.woff',
		"v4shim.css"          = 'html/font-awesome/css/v4-shims.min.css'
	)
	parents = list("font-awesome.css" = 'html/font-awesome/css/all.min.css')

/datum/asset/simple/namespaced/tgfont
	assets = list(
		"tgfont.eot" = file("tgui/packages/tgfont/dist/tgfont.eot"),
		"tgfont.woff2" = file("tgui/packages/tgfont/dist/tgfont.woff2"),
	)
	parents = list(
		"tgfont.css" = file("tgui/packages/tgfont/dist/tgfont.css")
	)

/datum/asset/spritesheet/chat
	name = "chat"

/datum/asset/spritesheet/chat/register()
	InsertAll("emoji", 'icons/misc/emoji.dmi')
	// pre-loading all lanugage icons also helps to avoid meta
	InsertAll("language", 'icons/misc/language.dmi')
	// catch languages which are pulling icons from another file
	for(var/path in typesof(/datum/language))
		var/datum/language/L = path
		var/icon = initial(L.icon)
		if (icon != 'icons/misc/language.dmi')
			var/icon_state = initial(L.icon_state)
			Insert("language-[icon_state]", icon, icon_state=icon_state)
	..()

/datum/asset/simple/namespaced/common
	assets = list("padlock.png"	= 'html/images/padlock.png')
	parents = list("common.css" = 'html/browser/common.css')

/datum/asset/simple/permissions
	assets = list(
		"search.js" = 'html/browser/search.js',
		"panels.css" = 'html/browser/panels.css'
	)

/datum/asset/group/permissions
	children = list(
		/datum/asset/simple/permissions,
		/datum/asset/simple/namespaced/common,
	)

/datum/asset/simple/notes
	assets = list(
		"high_button.png" = 'html/images/high_button.png',
		"medium_button.png" = 'html/images/medium_button.png',
		"minor_button.png" = 'html/images/minor_button.png',
		"none_button.png" = 'html/images/none_button.png',
	)


//this exists purely to avoid meta by pre-loading all language icons.
/datum/asset/language/register()
	for(var/path in typesof(/datum/language))
		set waitfor = FALSE
		var/datum/language/L = new path ()
		L.get_icon()

/datum/asset/simple/orbit
	assets = list(
		"ghost.png" = 'html/images/ghost.png'
	)

/datum/asset/spritesheet/blessingmenu
	name = "blessingmenu"

/datum/asset/spritesheet/blessingmenu/register()
	InsertAll("", 'icons/UI_Icons/buyable_icons.dmi')
	..()

// 32x32
/datum/asset/spritesheet/crafting_buttons
	name = "crafting_buttons"

/datum/asset/spritesheet/crafting_buttons/register()
	var/list/atoms = list()
	for(var/datum/crafting_recipe/recipe as anything in GLOB.crafting_recipes)
		atoms |= recipe.result
	for(var/atom/atom as anything in atoms)
		var/icon/icon = icon(initial(atom.icon), initial(atom.icon_state))
		Insert(replacetext("button_small[atom]", "/", "_"), icon)
	..()

// 96x96
/datum/asset/spritesheet/crafting_buttons
	name = "crafting_buttons"

/datum/asset/spritesheet/crafting_buttons/register()
	var/list/atoms = list()
	for(var/datum/crafting_recipe/recipe as anything in GLOB.crafting_recipes)
		atoms |= recipe.result
	for(var/atom/atom as anything in atoms)
		var/icon/icon = icon(initial(atom.icon), initial(atom.icon_state))
		icon.Scale(96, 96)
		Insert(replacetext("button[atom]", "/", "_"), icon)
	..()

/datum/asset/spritesheet/recipe_icons
	name = "recipe_icons"

/datum/asset/spritesheet/recipe_icons/register()
	. = list(
		"items" = list(),
		"tools" = list(),
		"crafting_qualities" = list(),
		"reagents" = list(),
		"materials" = list()
		)

	for(var/datum/crafting_recipe/recipe as anything in GLOB.crafting_recipes)
		.["items"] |= recipe.base_item
		for(var/step in recipe.steps)
			switch(step[1])
				if(CRAFT_ITEM)
					.["items"] |= step[2]

				if(CRAFT_TOOL)
					.["tools"] |= step[2]

				if(CRAFT_CRAFTING_QUALITY)
					LAZYORASSOCLIST(.["crafting_qualities"], step[2], step[4])

				if(CRAFT_REAGENT)
					.["reagents"] |= step[2]

				if(CRAFT_MATERIAL)
					.["materials"] |= step[2]

	for(var/atom/item as anything in .["items"])
		Insert(replacetext("recipe_icon[item]", "/", "_"), initial(item.icon), initial(item.icon_state))

	for(var/tool_quality in .["tools"])
		var/atom/tool = GLOB.iconic_tools[tool_quality]
		Insert("recipe_icon[tool_quality]", initial(tool.icon), initial(tool.icon_state))

	for(var/list/craft_quality as anything in .["crafting_qualities"])
		var/atom/atom = GLOB.crafting_qualities_icons[craft_quality][.["crafting_qualities"][craft_quality]]
		Insert(replacetext("recipe_icon[atom]", "/", "_"), initial(atom.icon), initial(atom.icon_state))

	for(var/datum/reagent/reagent as anything in .["reagents"])
		var/icon/filling = icon('icons/obj/reagentfillings.dmi', "beakerlarge100")
		var/hex_num = hex2num(initial(reagent.color))
		filling.Blend(rgb(copytext(hex_num, 2, 4), copytext(hex_num, 4, 6), copytext(hex_num, 6, 8)))
		Insert(replacetext("recipe_icon[reagent]", "/", "_"), filling)

	for(var/obj/item/stack/stack as anything in .["materials"])
		Insert(replacetext("recipe_icon[stack]", "/", "_"), initial(stack.icon), initial(stack.icon_state))
	..()
