extends WhiteMagicBase
class_name CureBase

var current_move_info

var healing_attempt_templates = [
	"-{USER} cast {MOVE} on {TARGET}"
]

var healing_result_templates = [
	"-{TARGET} gained {DAMAGE_INCURRED} hp",
	"-{TARGET} was healed by {DAMAGE_INCURRED} hp",
]


func generate_announcement_string(move_info):
	var move = move_info["move"]
	var user = move_info["user"]
	var target = move_info["target"]
	var stolen_item = move_info["stolen_item"]
	var critical = move_info["critical"]
	var damage_output = move_info["move_power"]
	var damage_incurred = move_info["damage_incurred"]

	var selected_template = healing_attempt_templates.pick_random()
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
		damage_string = generate_failure_string()
	elif damage_incurred < 0:
		damage_string = generic_damage_templates.pick_random().replace(
			"{TARGET}",
			target.fighter_name
		).replace(
			"{DAMAGE_INCURRED}",
			str(damage_incurred)
		)

	elif damage_incurred > 0:
		damage_string = generic_healing_templates.pick_random().replace(
			"{TARGET}",
			target.fighter_name
		).replace(
			"{DAMAGE_INCURRED}",
			str(damage_incurred)
		)

	announcement_string += "\n\n" + damage_string

	return announcement_string

func use_move(
	move_info,
	success_roll,
	crit_roll
):
	current_move_info = move_info
	var move = move_info["move"]

	move_info = use_magic_healing(
		move_info,
		success_roll,
		crit_roll
	)

	return move_info

func use_magic_healing(move_info, success_roll, crit_roll):
	var move = move_info["move"]
	var user = move_info["user"]
	var fighter_magic = user.fighter_magic
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
		damage_output = fighter_magic + move_base_power + weapon_bonus
	elif move_base_power == 0:
		damage_output = 0

	if crit:
		damage_output += weapon_bonus

	move_info["success"] = calculate_move_success(move_info, success_roll)
	move_info["move_power"] = damage_output
	move_info["critical"] = crit

	user.animated_sprite.animation_looped.connect(
		_on_cast_complete
	)
	user.animated_sprite.set_visible(true)
	user.animated_sprite.play("spell_cast")

	return move_info

func _on_cast_complete():
	var user = current_move_info["user"]	
	var target = current_move_info["user"]	

	user.animated_sprite.set_visible(false)
	user.animated_sprite.stop()
	user.animated_sprite.animation_looped.disconnect(
		_on_cast_complete
	)

	target.receive_move(current_move_info)
