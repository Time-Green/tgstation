/datum/station_trait/nebula/bluespace
	name = "Bluespace Nebula"
	weight = 1
	force = TRUE

	nebula_layer = /atom/movable/screen/parallax_layer/random/space_gas/bluespace
	blacklist = list(/datum/station_trait/nebula/hostile/radiation)

	/// Area's influenced by the bluespace stuff
	var/bluespaced_areas = list(/area/space, /area/station/solars)

/datum/station_trait/nebula/bluespace/New()
	. = ..()

	var/old_list = bluespaced_areas
	for(var/area_type in old_list)
		bluespaced_areas += subtypesof(area_type)

	var/list/area_instances = list()
	for(var/area_type in bluespaced_areas)
		area_instances |= get_areas(bluespaced_areas)

	for(var/area/target as anything in area_instances)
		RegisterSignal(target, COMSIG_AREA_ENTERED, PROC_REF(on_entered))
		RegisterSignal(target, COMSIG_AREA_EXITED, PROC_REF(on_exited))

/datum/station_trait/nebula/bluespace/proc/on_entered(area/space, atom/movable/enterer, area/old_area)
	SIGNAL_HANDLER

	if(isliving(enterer) && !(old_area.type in bluespaced_areas))
		enterer.AddElement(/datum/element/bluespace_swimmy_movement)

/datum/station_trait/nebula/bluespace/proc/on_exited(area/space, atom/movable/exiter, direction)
	SIGNAL_HANDLER

	if(!isliving(exiter))
		return

	var/area/new_area = get_area(exiter)
	if(!(new_area in bluespaced_areas))
		exiter.RemoveElement(/datum/element/bluespace_swimmy_movement)

/datum/element/bluespace_swimmy_movement

/datum/element/bluespace_swimmy_movement/Attach(datum/target)
	. = ..()

	if(!isliving(target))
		return ELEMENT_INCOMPATIBLE

	var/mob/living/living = target
	living.overlay_fullscreen("bluespace", /atom/movable/screen/fullscreen/bluespace_engulfed)

/datum/element/bluespace_swimmy_movement/Detach(datum/source, ...)
	. = ..()

	var/mob/living/living = source
	living.clear_fullscreen("bluespace", 0.5 SECONDS)

/atom/movable/screen/fullscreen/bluespace_engulfed
	icon_state = "bluespace1"
	/// Icon states we use at certain times
	var/list/icon_changes = list(
		"bluespace2" = 30 SECONDS,
		"bluespace3" = 90 SECONDS,
	)

/atom/movable/screen/fullscreen/bluespace_engulfed/Initialize(mapload, datum/hud/hud_owner)
	. = ..()

	alpha = 0
	animate(src, alpha = 255, time = 0.5 SECONDS)

	for(var/new_icon_state in icon_changes)
		addtimer(VARSET_CALLBACK(src, icon_state, new_icon_state), icon_changes[new_icon_state])
