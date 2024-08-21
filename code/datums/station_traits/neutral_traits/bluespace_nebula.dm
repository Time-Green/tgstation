/datum/station_trait/nebula/bluespace
	name = "Bluespace Nebula"
	weight = 1
	force = TRUE

	nebula_layer = /atom/movable/screen/parallax_layer/random/space_gas/bluespace
	blacklist = list(/datum/station_trait/nebula/hostile/radiation)

	/// Area's influenced by the bluespace stuff
	var/bluespaced_areas = /area/space

/datum/station_trait/nebula/bluespace/New()
	. = ..()

	for(var/area/target as anything in get_areas(bluespaced_areas))
		RegisterSignal(target, COMSIG_AREA_ENTERED, PROC_REF(on_entered))
		RegisterSignal(target, COMSIG_AREA_EXITED, PROC_REF(on_exited))

/datum/station_trait/nebula/bluespace/proc/on_entered(area/space, atom/movable/enterer, area/old_area)
	SIGNAL_HANDLER

	if(isliving(enterer))
		enterer.AddElement(/datum/element/bluespace_swimmy_movement)

/datum/station_trait/nebula/bluespace/proc/on_exited(area/space, atom/movable/exiter, direction)
	SIGNAL_HANDLER

	if(isliving(exiter))
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
	icon_state = "bluespace"

/atom/movable/screen/fullscreen/bluespace_engulfed/Initialize(mapload, datum/hud/hud_owner)
	. = ..()

	alpha = 0
	animate(src, alpha = 255, time = 0.5 SECONDS)
