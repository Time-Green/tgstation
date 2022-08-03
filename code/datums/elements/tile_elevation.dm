#define TILES 50

/datum/element/tile_elevation
	element_flags = ELEMENT_BESPOKE | ELEMENT_DETACH

	var/elevation = TILES * 0.2
	var/planeshift = 3

/datum/element/tile_elevation/Attach(datum/target)
	. = ..()

	if(!istype(target, /turf))
		return ELEMENT_INCOMPATIBLE

	var/turf/tile = target
	tile.pixel_y += elevation
	tile.plane += planeshift
	AdjustContents(tile, elevation, planeshift)

	RegisterSignal(tile, COMSIG_ATOM_ENTERED, .proc/elevate)
	RegisterSignal(tile, COMSIG_ATOM_EXITED, .proc/unelevate)

/datum/element/tile_elevation/Detach(turf/tile, ...)
	. = ..()

	tile.pixel_y -= elevation
	tile.plane -= planeshift
	AdjustContents(tile, -elevation, -planeshift)

	UnregisterSignal(tile, COMSIG_ATOM_ENTERED, COMSIG_ATOM_EXITED)


/datum/element/tile_elevation/proc/AdjustContents(turf/tile, elevation, _planeshift)
	for(var/atom/movable/elevatee in tile.contents)
		elevatee.pixel_y += elevation
		elevatee.plane += _planeshift

/datum/element/tile_elevation/proc/elevate(turf/source, atom/movable/enterer)
	SIGNAL_HANDLER

	enterer.pixel_y += elevation
	enterer.plane += planeshift

/datum/element/tile_elevation/proc/unelevate(turf/source, atom/movable/leaver)
	SIGNAL_HANDLER

	leaver.pixel_y -= elevation
	leaver.plane -= planeshift

/obj/item/elevator/attack_self(mob/user, modifiers)
	. = ..()

	for(var/turf/tile in range(0, user))
		tile.AddElement(/datum/element/tile_elevation)
