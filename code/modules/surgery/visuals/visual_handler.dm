/datum/surgery_visual
	var/body_zone
	/// Optional, if set, applies it to
	var/datum/bodypart_overlay/bodypart_overlay
	/// Index list of body zones to the corresponding subtype : BODY_ZONE_CHEST = /datum/surgery_visual/booshka/chest
	var/type_to_slot = list()

	var/mob/living/carbon/owner

	var/obj/item/bodypart/bodypart

/datum/surgery_visual/proc/apply_to(mob/living/carbon/owner, obj/item/bodypart/bodypart)
	src.owner = owner
	src.bodypart = bodypart
	apply_visuals()

/datum/surgery_visual/proc/apply_visuals()
	apply_bodypart_overlay()

/datum/surgery_visual/proc/apply_bodypart_overlay()
	if(bodypart_overlay)
		bodypart_overlay = new bodypart_overlay ()
		bodypart.add_bodypart_overlay(bodypart_overlay)

/datum/surgery_visual/proc/remove_from()
	remove_visuals()
	owner = null
	bodypart = null

/datum/surgery_visual/proc/remove_visuals()
	remove_bodypart_overlay()

/datum/surgery_visual/proc/remove_bodypart_overlay()
	if(bodypart_overlay)
		bodypart.remove_bodypart_overlay(bodypart_overlay)



