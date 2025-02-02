/datum/surgery_visual/opened

/datum/surgery_visual/opened/chest
	body_zone = BODY_ZONE_CHEST
	bodypart_overlay = /datum/bodypart_overlay/simple/draped_chest

/datum/surgery_visual/opened/head
	body_zone = BODY_ZONE_HEAD
	bodypart_overlay = null

/datum/surgery_visual/opened/head/apply_visuals()
	. = ..()

	owner.add_filter("head is cut open", 1, list(type = "alpha", icon = icon('icons/mob/human/species/misc/organs.dmi', "half_head_mask")))

/datum/surgery_visual/opened/head/brain

/datum/surgery_visual/opened/head/brain/apply_to(mob/living/carbon/owner, obj/item/bodypart/bodypart)
	. = ..()

	RegisterSignal(owner, COMSIG_CARBON_GAIN_ORGAN, PROC_REF(on_gain_organ))
	RegisterSignal(owner, COMSIG_CARBON_LOSE_ORGAN, PROC_REF(on_lose_organ))

/datum/surgery_visual/opened/head/brain/apply_visuals()
	. = ..()

	apply_bodypart_overlay(owner, bodypart)

/datum/surgery_visual/opened/head/brain/apply_bodypart_overlay()
	var/obj/item/organ/brain/brain = owner.get_organ_slot(ORGAN_SLOT_BRAIN)

	if(!brain || !brain.brain_overlay)
		return

	bodypart_overlay = brain.brain_overlay
	return ..()

/datum/surgery_visual/opened/head/brain/proc/on_gain_organ(mob/living/carbon/owner, obj/item/organ/organ)
	SIGNAL_HANDLER

	if(!istype(organ, /obj/item/organ/brain))
		return

	apply_bodypart_overlay()

/datum/surgery_visual/opened/head/brain/proc/on_lose_organ(mob/living/carbon/owner, obj/item/organ/organ)
	SIGNAL_HANDLER

	if(!istype(organ, /obj/item/organ/brain))
		return

	remove_bodypart_overlay()
