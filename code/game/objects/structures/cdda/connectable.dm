/obj/structure/connectable
	name = "fence"
	desc = "A large metal mesh strewn between two poles. Intended as a cheap way to separate areas, while allowing one to see through it."
	icon = 'cdda/icons/fences.dmi'
	icon_state = "fence_wood_0"
	density = TRUE
	throwpass = TRUE //So people and xenos can shoot through!
	anchored = TRUE //We can not be moved.
	layer = WINDOW_LAYER
	max_integrity = 150 //Its cheap but still viable to repair, cant be moved around, about 7 runner hits to take down
	resistance_flags = XENO_DAMAGEABLE
	minimap_color = MINIMAP_FENCE
	coverage = 15 //Were like 4 rods
	var/basestate = "fence_wood_"
	var/list/connectable_types

/obj/structure/connectable/Initialize(mapload, ...)
	.=..()
	update_icon(!mapload)

/obj/structure/connectable/update_icon(update_nearby = FALSE)
	var/dir_sum = 0
	for(var/direction in GLOB.cardinals)
		var/turf/turf = get_step(src, direction)
		for(var/obj/structure/connectable/structure in turf)
			if((istype(structure, type) || is_type_in_list(structure, connectable_types)) && !QDELING(structure))
				dir_sum += direction
				if(update_nearby)
					structure.update_icon()
				break
	icon_state = "[basestate][dir_sum]"

/obj/structure/connectable/Destroy(force)
	.=..()
	for(var/direction in GLOB.cardinals)
		var/turf/turf = get_step(src, direction)
		for(var/obj/structure/connectable/structure in turf)
			if((istype(structure, type) || is_type_in_list(structure, connectable_types)) && !QDELING(structure))
				structure.update_icon()

/*
	Subtypes below
*/

/obj/structure/connectable/sandbag
	name = "sandbag"
	icon = 'cdda/icons/baricades.dmi'
	icon_state = "sandbag_0"
	max_integrity = 300 //Pretty tough
	coverage = 60
	climbable = TRUE
	basestate = "sandbag_"

/obj/structure/connectable/fence
	name = "wooden fence"
	icon_state = "fence_wood_0"
	max_integrity = 75
	coverage = 25
	climbable = TRUE
	basestate = "fence_wood_"

/obj/structure/connectable/fence/wooden
	name = "wooden fence"
	icon_state = "fence_wood_0"
	max_integrity = 75
	coverage = 25
	climbable = TRUE
	basestate = "fence_wood_"

/obj/structure/connectable/fence/barbed
	name = "wooden fence"
	icon_state = "fence_barbed_0"
	max_integrity = 75
	coverage = 25
	climbable = TRUE
	basestate = "fence_barbed_"

/obj/structure/connectable/fence/garden
	name = "wooden fence"
	icon_state = "fence_garden_0"
	max_integrity = 75
	coverage = 25
	climbable = TRUE
	basestate = "fence_garden_"

/obj/structure/connectable/fence/rope
	name = "wooden fence"
	icon_state = "fence_rope_0"
	max_integrity = 75
	coverage = 25
	climbable = TRUE
	basestate = "fence_rope_"

/obj/structure/connectable/fence/wire
	name = "wooden fence"
	icon_state = "fence_wire_0"
	max_integrity = 75
	coverage = 25
	climbable = TRUE
	basestate = "fence_wire_"

/obj/structure/connectable/fence/chain
	name = "wooden fence"
	icon_state = "fence_chain_0"
	max_integrity = 75
	coverage = 25
	climbable = TRUE
	basestate = "fence_chain_"

/obj/structure/connectable/palisade
	name = "palisade"
	icon = 'cdda/icons/baricades.dmi'
	icon_state = "palisade_0"
	max_integrity = 300
	coverage = 100
	throwpass = FALSE
	basestate = "palisade_"
