/mob/living/simple_animal/hostile/zombie
	name = "Shambling Corpse"
	desc = "When there is no more room in hell, the dead will walk the Earth."
	icon = 'icons/mob/zombie.dmi'
	icon_state = "z1"
	icon_living = "z1"
//	icon_dead = "[icon_living]_dead" Left in for future use. Needs sprites made. Remove del_on_death when you do this.
//	icon_gib = "" This also needs sprites made.
	speak_chance = 0
	turns_per_move = 5
	emote_taunt = list("growls")
	taunt_chance = 35
	speed = 0
	maxHealth = 100
	health = 100
	del_on_death = 1

	harm_intent_damage = 5
	obj_damage = 10
	melee_damage = 15
	attacktext = "bites"
	attack_sound = 'sound/hallucinations/growl1.ogg'
	speak_emote = list("bites")

/mob/living/simple_animal/hostile/zombie/Initialize()
	. = ..()
	icon_state = "z[rand(1,7)]"
	icon_living = icon_state

/mob/living/simple_animal/hostile/zombie/hulk
	name = "Giant Zombie"
	desc = "When there is no more room in hell, the giant dead will make room."
	icon = 'icons/mob/hulk.dmi'
	icon_state = "hulk_1"
	icon_living = "hulk_1"

	wall_smash = 1
	maxHealth = 500
	health = 500
	harm_intent_damage = 5
	melee_damage = 50

/mob/living/simple_animal/hostile/zombie/hulk/Initialize()
	. = ..()
	icon_state = "hulk_[rand(1,3)]"
	icon_living = icon_state

/*mob/living/simple_animal/hostile/zombie/proc/setup_visuals() // Commenting this out in case someone wants to do something with it later, delete if not needed
//	var/datum/job/job = SSjob.GetJob(zombiejob)

//	var/datum/outfit/outfit = new job.outfit
//	outfit.l_hand = null
//	outfit.r_hand = null

	var/mob/living/carbon/human/dummy/dummy = new
//	dummy.equipOutfit(outfit)
	dummy.set_species(/datum/species/zombie)
	icon = getFlatIcon(dummy)
	qdel(dummy)

/mob/living/simple_animal/hostile/zombie/AttackingTarget()
	. = ..()
	if(. && ishuman(target) && prob(infection_chance))
		try_to_zombie_infect(target)*/
