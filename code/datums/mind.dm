/*	Note from Carnie:
		The way datum/mind stuff works has been changed a lot.
		Minds now represent IC characters rather than following a client around constantly.

	Guidelines for using minds properly:

	-	When creating a new mob for an existing IC character (e.g. cloning a dead guy or borging a brain of a human)
		the existing mind of the old mob should be transfered to the new mob like so:

			mind.transfer_to(new_mob)

	-	You must not assign key= or ckey= after transfer_to() since the transfer_to transfers the client for you.
		By setting key or ckey explicitly after transfering the mind with transfer_to you will cause bugs like DCing
		the player.

	-	IMPORTANT NOTE 2, if you want a player to become a ghost, use mob.ghostize() It does all the hard work for you.

	-	When creating a new mob which will be a new IC character (e.g. putting a shade in a construct or randomly selecting
		a ghost to become a xeno during an event). Simply assign the key or ckey like you've always done.

			new_mob.key = key

		The Login proc will handle making a new mob for that mobtype (including setting up stuff like mind.name). Simple!
		However if you want that mind to have any special properties like being a traitor etc you will have to do that
		yourself.

*/
/datum/mind
	var/key
	var/name
	var/mob/living/current
	var/active = FALSE

	var/memory

	var/list/datum/crafting_recipe/learned_recipes = list()

	var/datum/money_account/initial_account

	var/last_death = 0

	var/bypass_ff = FALSE


/datum/mind/New(key)
	src.key = key


/datum/mind/Destroy(force, ...)
	current = null
	if(initial_account)
		QDEL_NULL(initial_account)
	return ..()


/datum/mind/proc/transfer_to(mob/new_character, force_key_move = FALSE)
	if(current)	// remove ourself from our old body's mind variable
		current.mind = null
		SStgui.on_transfer(current, new_character)

	if(key)
		if(new_character.key != key)					//if we're transferring into a body with a key associated which is not ours
			new_character.ghostize(TRUE)						//we'll need to ghostize so that key isn't mobless.
	else
		key = new_character.key

	if(new_character.mind)								//disassociate any mind currently in our new body's mind variable
		new_character.mind.current = null

	current = new_character								//associate ourself with our new body
	new_character.mind = src							//and associate our new body with ourself

	if(active || force_key_move)
		new_character.key = key		//now transfer the key to link the client to our new body


/datum/mind/proc/set_death_time()
	last_death = world.time


/datum/mind/proc/store_memory(new_text)
	var/newlength = length_char(memory) + length_char(new_text)
	if (newlength > MAX_PAPER_MESSAGE_LEN)
		memory = copytext_char(memory, -newlength - MAX_PAPER_MESSAGE_LEN)
	memory += "[new_text]<BR>"


/datum/mind/proc/wipe_memory()
	memory = null


/datum/mind/proc/show_memory(mob/recipient)
	var/output = "<b>[current.real_name]'s Memory</b><hr>"
	output += memory

	recipient << browse(output, "window=memory")

//Use this proc instead of adding new recipes directly into learned_recipes
/datum/mind/proc/learn_recipe(datum/crafting_recipe/recipe)
	learned_recipes |= recipe
	SEND_SIGNAL(src, COMSIG_ADD_NEW_CATEGORY, recipe.category)

/mob/proc/mind_initialize()
	if(mind)
		mind.key = key
	else
		mind = new /datum/mind(key)
	if(!mind.name)
		mind.name = real_name
	mind.current = src
