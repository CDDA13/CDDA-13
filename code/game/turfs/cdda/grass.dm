/turf/open/floor/plating/ground
	name = "grass"
	icon = 'cdda/icons/grass.dmi'
	icon_state = "green0"
	shoefootstep = FOOTSTEP_GRASS
	barefootstep = FOOTSTEP_GRASS
	mediumxenofootstep = FOOTSTEP_GRASS

/turf/open/floor/plating/ground/small
	name = "small grass"
	icon_state = "grass"

/turf/open/floor/plating/ground/small/Initialize(mapload, ...)
	setDir(pick(GLOB.cardinals))
	.=..()

/turf/open/floor/plating/ground/small/Destroy(force)
	for(var/direction in GLOB.cardinals)
		var/turf/turf = get_step(src, direction)
		if(istype(turf, /turf/open/floor/plating/ground/dirt) && !QDELING(turf))
			turf.update_icon(FALSE)
	.=..()

/turf/open/floor/plating/ground/dirt
	name = "dirt"
	icon_state = "dirt_0"
	var/overlay_type
	var/overlay

/turf/open/floor/plating/ground/dirt/Initialize(mapload, ...)
	.=..()
	if(!overlay_type)
		if(prob(25))
			overlay_type = "grassO_"
		else if(prob(25))
			overlay_type = "mossO_"
		else if(prob(25))
			overlay_type = "grassLongO_"
		else if(prob(25))
			overlay_type = "grassDeadO_"
	.=INITIALIZE_HINT_LATELOAD

/turf/open/floor/plating/ground/dirt/LateInitialize(mapload)
	update_icon(!mapload)

/turf/open/floor/plating/ground/dirt/update_icon(update_nearby = FALSE)
	var/dir_sum = 0
	var/overlay_dir_sum = 0
	cut_overlay(overlay)
	for(var/direction in GLOB.cardinals)
		var/turf/turf = get_step(src, direction)
		if(!QDELING(turf))
			if(istype(turf, /turf/open/floor/plating/ground/small))
				dir_sum += direction
				if(update_nearby)
					turf.update_icon()
			if(istype(turf, /turf/open/floor/plating/ground/dirt))
				var/turf/open/floor/plating/ground/dirt/dirt = turf
				if(!dirt.overlay_type || dirt.overlay_type != overlay_type)
					continue
				overlay_dir_sum += direction
				if(update_nearby)
					turf.update_icon()
	icon_state = "dirt_[dir_sum]"
	if(overlay_type)
		add_overlay("[overlay_type][overlay_dir_sum]")
		overlay = "[overlay_type][overlay_dir_sum]"

/turf/open/floor/plating/ground/dirt/Destroy(force)
	.=..()
	for(var/direction in GLOB.cardinals)
		var/turf/turf = get_step(src, direction)
		if(istype(turf, type) && !QDELING(turf))
			turf.update_icon(FALSE)
