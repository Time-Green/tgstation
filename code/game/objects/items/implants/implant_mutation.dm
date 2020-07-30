/obj/item/implant/mutation
	name = "mutation implant"
	desc = "Apply and remove mutations at will."
	icon_state = "monkey"
	implant_color = "r"

	var/cooldown = 5 SECONDS
	var/on_cooldown

	//Which mutation do we give/take?
	var/mutation = SPECIES_ADAPT

/obj/item/implant/mutation/activate()
	. = ..()

	if(on_cooldown)
		return

	if(imp_in.has_dna() && iscarbon(imp_in))
		var/mob/living/carbon/C = imp_in

		if(C.dna.get_mutation(mutation))
			C.dna.remove_mutation(mutation)
		else
			C.dna.add_mutation(mutation, MUT_EXTRA)

	on_cooldown = addtimer(VARSET_CALLBACK(src, on_cooldown, null), cooldown , TIMER_STOPPABLE)
