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

/// Crate that is a clam >:)
/obj/structure/closet/crate/clam
	name = "clam"
	desc = "A beautifully ornate, but completely biological, clam."
	icon = 'icons/obj/bluespace_nebula/clam.dmi'
	icon_state = "clam"
	base_icon_state = "clam"

/obj/structure/flora/coral
	name = "space coral"
	desc = "Coral but in space."
	icon = 'icons/obj/bluespace_nebula/reefgrow.dmi'
	icon_state = "crystal_reef"
	base_icon_state = "crystal_reef"
	gender = PLURAL
	product_types = list(/obj/item/food/grown/ash_flora/shavings = 1)
	harvest_with_hands = TRUE
	harvested_name = "small coral"
	harvested_desc = "If left alone, will grow to be a big and strong coral."
	harvest_message_low = "You pick some of the coral."
	harvest_message_med = "You pick a portion of the coral."
	harvest_message_high = "You pick a large chunk of coral."
	harvest_message_true_thresholds = TRUE
	harvest_verb = "pick"
	flora_flags = FLORA_HERBAL
	/// Variants we have, used for icons. icon_state = base_icon_state + "[variants]"
	var/variants = 3

/obj/structure/flora/coral/Initialize(mapload)
	. = ..()
	base_icon_state = "[base_icon_state][rand(1, number_of_variants)]"
	icon_state = base_icon_state

/obj/structure/flora/coral/electric
	name = "electric space coral"
	desc = "Shocking!"
	icon_state = "reefelectric"
	base_icon_state = "reefelectric"
