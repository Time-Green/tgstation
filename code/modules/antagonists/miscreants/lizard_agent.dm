/datum/antagonist/miscreant/lizard_agent
	name = "Lizard Agent"
	silent = FALSE

	miscreant_weight = 20
	whitelisted_roles = list("Head of Personnel", "Head of Security", "Captain", "Chief Medical Officer", "Research Director", "Chief Engineer")

/datum/antagonist/miscreant/lizard_agent/apply_innate_effects()
	if(ishuman(owner.current))
		var/mob/living/carbon/human/H = owner.current

		H.set_species(/datum/species/lizard)
		var/obj/item/implant/mutation/M = new /obj/item/implant/mutation(H)
		M.implant(H)
		M.activate()

	else
		CRASH("Tried to assign the Lizard Agent antag datum to non-human")

