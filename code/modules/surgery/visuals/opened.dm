/datum/surgery_visual/opened
	type_to_slot = list(
		BODY_ZONE_CHEST = /datum/surgery_visual/draped/chest,
		BODY_ZONE_HEAD = /datum/surgery_visual/opened/head,
	)

/datum/surgery_visual/opened/chest
	body_zone = BODY_ZONE_CHEST
	bodypart_overlay = /datum/bodypart_overlay/simple/draped_chest

/datum/surgery_visual/opened/head
	body_zone = BODY_ZONE_HEAD
	bodypart_overlay = null

/datum/surgery_visual/opened/head/apply_to(mob/living/carbon/owner, obj/item/bodypart/bodypart)
	. = ..()

	owner.add_filter("head is cut open", 1, list(type = "alpha", icon = icon('icons/mob/human/species/misc/bodypart_overlay_simple.dmi', "half_head_mask")))

/datum/surgery_visual/opened/head/remove_from(mob/living/carbon/owner, obj/item/bodypart/bodypart)
	. = ..()

	owner.remove_filter("head is cut open")
