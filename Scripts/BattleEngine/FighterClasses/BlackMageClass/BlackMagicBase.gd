extends base_move
class_name BlackMagicBase

var current_move_info

func use_move(
	move_info,
	success_roll,
	crit_roll
):
	current_move_info = move_info
	var move = move_info["move"]

	move_info = use_magic_attack(
		move_info,
		success_roll,
		crit_roll
	)

	return move_info

func use_magic_attack(move_info, success_roll, crit_roll):
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
	user.animated_sprite.animation_looped.disconnect(
		_on_cast_complete
	)

	target.receive_move(current_move_info)
