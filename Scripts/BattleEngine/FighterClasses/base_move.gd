class_name base_move

var generic_attempt_templates = [
	"-{USER} used {MOVE} on {TARGET}.",
	"-{USER} performed {MOVE} on {TARGET}.",
	"-{USER} slapped {TARGET} with a {MOVE}.",
]

var generic_damage_templates = [
	"-{TARGET} took {DAMAGE_INCURRED} damage.",
	"-{TARGET} suffered {DAMAGE_INCURRED} damage.",
]

var generic_healing_templates = [
	"-{TARGET} gained {DAMAGE_INCURRED} hp",
	"-{TARGET} was healed by {DAMAGE_INCURRED} hp",
]

func generate_failure_string():
	return "But it failed..."

func generate_announcement_string(move_info):

	var move = move_info["move"]
	var user = move_info["user"]
	var target = move_info["target"]
	var stolen_item = move_info["stolen_item"]
	var critical = move_info["critical"]
	var damage_output = move_info["move_power"]
	var damage_incurred = move_info["damage_incurred"]

	var selected_template = generic_attempt_templates.pick_random()
	var announcement_string = selected_template.replace(
		"{USER}",
		user.fighter_name
	).replace(
		"{TARGET}",
		target.fighter_name
	).replace(
		"{MOVE}",
		move.move_name	
	)
	var damage_string

	if move_info["success"] == false:
		damage_string = "-But the move failed..."
	elif damage_incurred > 0:
		damage_string = generic_damage_templates.pick_random().replace(
			"{TARGET}",
			target.fighter_name
		).replace(
			"{DAMAGE_INCURRED}",
			str(damage_incurred)
		)

	elif damage_incurred < 0:
		damage_string = generic_healing_templates.pick_random().replace(
			"{TARGET}",
			target.fighter_name
		).replace(
			"{DAMAGE_INCURRED}",
			str(-1 * damage_incurred)
		)

	announcement_string += "\n\n" + damage_string

	return announcement_string

func use_move(
	move_info,
	success_roll,
	crit_roll
):
	#current_move_info = move_info
	var move = move_info["move"]
	var move_type = move.move_type

	if move_info["wait"] == true:
		move_info["wait"] = false
		return move_info
	else:
		var move_func = {
			"melee_attack": use_melee_attack,
			"gun_attack": use_gun_attack,
			"jump_prep": use_jump_prep,
			"item_attack": use_item_attack,
			"item_healing": use_item_healing,
		}.get(move_type, null) 
		
		if move_func == null:
			print(
				"BIG UFF the move_type key was not found: ",
				move_type
			)
			
		move_info = move_func.call(move_info, success_roll, crit_roll)

		return move_info
			

func use_melee_attack(move_info, success_roll, crit_roll):
	return use_physical_attack(move_info, success_roll, crit_roll)

func use_gun_attack(move_info, success_roll, crit_roll):
	return use_physical_attack(move_info, success_roll, crit_roll)

func use_jump_prep(move_info, success_roll, crit_roll):
	var user = move_info["user"]
	var jump_attack = user.gen_move_info(
		move_info["move"].next_move,
		move_info["user"],
		move_info["target"],
	)
	user.move_queue.push_back(
		jump_attack
	)

	user.animation_player.play("jump_prep")

	move_info["success"] = calculate_move_success(
		move_info,
		success_roll
	)

	if move_info["success"]:
		move_info["on_move_complete"].call()			
		var announcement_string = move_info["move"].generate_announcement_string(move_info)
		move_info["announcer_box"].make_announcement(announcement_string)

	return move_info

func use_item_attack(move_info, success_roll, crit_roll):
	pass

func use_item_healing(move_info, success_roll, crit_roll):
	pass

func use_physical_attack(move_info, success_roll, crit_roll):
	var move = move_info["move"]
	var user = move_info["user"]
	var target = move_info["target"]
	var fighter_attack = user.fighter_attack
	var weapon_bonus = user.weapon_bonus
	var crit = false

	if crit_roll < move.crit_rate:
		crit = true
	else:
		crit = false

	# Possibly, in here we may have to check for elemental powerup?

	var move_base_power = move.base_power
	var damage_output = 0
	if move_base_power > 0:
		damage_output = fighter_attack + move_base_power + weapon_bonus
	elif move_base_power == 0:
		damage_output = 0

	if crit:
		damage_output += weapon_bonus

	move_info["success"] = calculate_move_success(move_info, success_roll)
	move_info["move_power"] = damage_output
	move_info["critical"] = crit

	return move_info

func calculate_move_success(move_info, success_roll):
	var bp_cost = move_info["move"].bp_cost
	var user = move_info["user"]

	var success_rate = user.expend_bp(bp_cost)
	if success_rate == -1:
		user.update_hud()
		return true
	else:
		user.current_boost = 0
		user.fighter_hud.update_hud(
			user.current_boost, 
			user.max_boost
		)

		if success_roll < success_rate:
			return true
		else:
			return false
		# There is another steal check on the targetted fighter which selects which item the player receives
		# One of the items should be "spare change" or "pocket lint" as a euphemism for "failure".
		# Inventory will be a list of objects on all fighters. It will be set when a fighter is instantiated.
		# Then, GetStolen from will choose from this list at random.
		# It will not remove old items from list.

func empty_callback():
	pass
