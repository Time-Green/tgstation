/datum/surgery_visual/draped
	type_to_slot = list(
		BODY_ZONE_CHEST = /datum/surgery_visual/draped/chest,
		BODY_ZONE_HEAD = /datum/surgery_visual/draped/head,
	)

/datum/surgery_visual/draped/chest
	body_zone = BODY_ZONE_CHEST
	bodypart_overlay = /datum/bodypart_overlay/simple/draped_chest

/datum/surgery_visual/draped/head
	body_zone = BODY_ZONE_HEAD
	bodypart_overlay = /datum/bodypart_overlay/simple/draped_head

/datum/bodypart_overlay/simple/draped_chest
	icon_state = "draped_chest"
	icon = 'icons/mob/human/surgery.dmi'

	layers = BODY_ADJ_LAYER

/datum/bodypart_overlay/simple/draped_head
	icon_state = "draped_head"
	icon = 'icons/mob/human/surgery.dmi'

	layers = BODY_ADJ_LAYER


