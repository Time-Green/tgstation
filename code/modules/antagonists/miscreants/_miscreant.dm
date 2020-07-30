///A semi-peaceful antag. Is usually just a thematic weird crewmember with strange objectives. Can be job specific (IE only Psychiatrist can be a sissy hypnosis performer)
/datum/antagonist/miscreant
	name = "Miscreant"
	show_in_antagpanel = TRUE
	antagpanel_category = "Miscreants"
	show_name_in_check_antagonists = TRUE
	roundend_category = "miscreants"
	silent = TRUE

	///List of jobs we can pick from, none means all jobs. Whitelisted miscreants get priority to a job. "Assistant", "Medical Doctor", etc
	var/list/whitelisted_roles
	///Weight is how likely the miscreant is to get picked
	///I recommend making this stupid high for whitelisted_roles, otherwise one of the default miscreants will prob get picked
	var/miscreant_weight

/datum/antagonist/miscreant/on_gain()
	. = ..()

	//Ugly, but no one feels like repeatingly overriding a magic variable/proc for every subtype they make
	if(type == /datum/antagonist/miscreant)
		//Only once we get a job can we start picking a miscreant (because miscreants can be job specific)
		RegisterSignal(owner, list(COMSIG_JOB_RECEIVED), .proc/specialize)


/datum/antagonist/miscreant/proc/specialize()
	var/job = owner.assigned_role

	var/list/elligible_miscreants = list()

	for(var/datum/antagonist/miscreant/M in subtypesof(type))
		if(!LAZYLEN(whitelisted_roles) || job in whitelisted_roles)
			elligible_miscreants[M] = initial(M.miscreant_weight)

	//Addtimer because I have an rational fear of working with deleted objects
	addtimer(CALLBACK(owner, /datum/mind/.proc/add_antag_datum, pickweight(elligible_miscreants)), 0)

	owner.remove_antag_datum(type)





