/mob/living/simple_animal/hostile/zombie
	name = "zombie"
	icon = 'icons/mob/simple_human.dmi'
	icon_state = "zombie"
	icon_living = "zombie"
	icon_dead = "zombie_dead"
	icon_gib = "syndicate_gib"
	response_help = "pokes"
	response_disarm = "shoves"
	response_harm = "hits"
	speed = -1
	maxHealth = 125
	health = 125
	harm_intent_damage = 5
	melee_damage = 15
	attacktext = "bites"
	a_intent = INTENT_HARM
	attack_sound = 'sound/weapons/alien_claw_flesh1.ogg'
	faction = FACTION_ZOMBIE
	stop_automated_movement_when_pulled = TRUE


/mob/living/simple_animal/hostile/russian
	name = "Russian"
	desc = "For the Motherland!"
	icon = 'icons/mob/simple_human.dmi'
	icon_state = "russianmelee"
	icon_living = "russianmelee"
	icon_dead = "russianmelee_dead"
	icon_gib = "syndicate_gib"
	speak_chance = 0
	turns_per_move = 5
	response_help = "pokes"
	response_disarm = "shoves"
	response_harm = "hits"
	speed = 0
	maxHealth = 100
	health = 100
	harm_intent_damage = 5
	melee_damage = 15
	attacktext = "punches"
	attack_sound = 'sound/weapons/punch1.ogg'
	a_intent = INTENT_HARM
	status_flags = CANPUSH
	del_on_death = TRUE

/mob/living/simple_animal/hostile/zombie/New()
	..()
	if(prob(5))
		icon_state = "zombie1"
		icon_living = "zombie1"
		icon_dead = "zombie_dead"
	if(prob(5))
		icon_state = "zombie2"
		icon_living = "zombie2"
		icon_dead = "zombie_dead"
	if(prob(5))
		icon_state = "zombie3"
		icon_living = "zombie3"
		icon_dead = "zombie_dead"
	if(prob(5))
		icon_state = "zombie4"
		icon_living = "zombie4"
		icon_dead = "zombie_dead"
	if(prob(5))
		icon_state = "zombie5"
		icon_living = "zombie5"
		icon_dead = "zombie_dead"
	if(prob(5))
		icon_state = "zombie6"
		icon_living = "zombie6"
		icon_dead = "zombie_dead"

/mob/living/simple_animal/hostile/zombie/death(gibbing, deathmessage = "lets out a waning guttural screech, blood bubbling from its maw.", silent)
	if(stat == DEAD)
		return ..()
	if(!gibbing && !silent)
		playsound(src, 'sound/voice/alien_death.ogg', 50, TRUE)
	return ..()
