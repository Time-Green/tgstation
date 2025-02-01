GLOBAL_LIST_INIT(surgery_visuals, generate_surgery_visuals())

/proc/generate_surgery_visuals()
	. = list()
	for(var/visual_type in subtypesof(/datum/surgery_visual))
		.[visual_type] = new visual_type ()

/datum/surgery_visual
	var/body_zone
	/// Optional, if set, applies it to
	var/datum/bodypart_overlay/bodypart_overlay
	/// Index list of body zones to the corresponding subtype : BODY_ZONE_CHEST = /datum/surgery_visual/booshka/chest
	var/type_to_slot = list()

/datum/surgery_visual/proc/apply_to(mob/living/carbon/owner, obj/item/bodypart/bodypart)
	if(bodypart_overlay)
		bodypart.add_bodypart_overlay(new bodypart_overlay ())

/datum/surgery_visual/proc/remove_from(mob/living/carbon/owner, obj/item/bodypart/bodypart)
	if(bodypart_overlay)
		bodypart.remove_bodypart_overlay(locate(bodypart_overlay) in bodypart.bodypart_overlays)

