extends JumpBase
class_name JUMP

var move_name = "Jump Attack"
var base_power = 90
var move_type = "jump_attack"
var sub_selection = []
var friendly = false
var bp_cost = 0
var crit_rate = .25
var steal_item = false

#var user_original_x_position
#var user_original_y_position
#var current_move_info

var jump_template_strings = [
	"-{USER} fell from the sky on top of {TARGET}",
	"-{USER} slammed onto {TARGET}",
	"-{USER} leapt onto {TARGET}",
]

func generate_announcement_string(move_info):
	var announcement = jump_template_strings.pick_random().replace(
		"{USER}",
		move_info["user"].fighter_name
	).replace(
		"{TARGET}",
		move_info["target"].fighter_name
	)
	var damage = move_info["damage_incurred"]
	var damage_string = "-He did " + str(damage) + " damage."

	announcement += "\n\n" + damage_string

	return announcement

#func use_move(
#	move_info,
#	success_roll,
#	crit_roll
#):
#	var user = move_info["user"]
#	current_move_info = move_info
#	user_original_x_position = user.position.x
#	user_original_y_position = user.position.y
#	use_jump_attack(
#		move_info,
#		success_roll,
#		crit_roll
#	)
#
#
#func use_jump_attack(move_info, success_roll, crit_roll):
#	var user = move_info["user"]
#	var target = move_info["target"]
#	user.position.x = target.position.x
#	var y_displacement = user.position.y - target.position.y
#	user.position.y -= y_displacement
#	move_info = use_physical_attack(
#		move_info,
#		success_roll,
#		crit_roll
#	)	
#	user.z_index += 1
#	user.animation_player.play("jump_attack")
#	user.animation_player.animation_finished.connect(
#		_on_jump_complete
#	)
#
#	return move_info
#
#func _on_jump_complete(_animation_name):
#	var target = current_move_info["target"]
#	var user = current_move_info["user"]
#	target.receive_move(current_move_info)
#	user.animation_player.animation_finished.disconnect(
#		_on_jump_complete
#	)
#	var announcement = generate_announcement_string(current_move_info)
#	current_move_info["announcer_box"].make_announcement(
#		announcement
#	)
#	user.position.x = user_original_x_position
#	user.position.y = user_original_y_position
#	user.z_index -= 1	
#
#	user.animation_player.animation_finished.connect(
#		_on_jump_return
#	)
#	user.animation_player.play("jump_return")
#
#func _on_jump_return(_animation_name):
#	var user = current_move_info["user"]
#	user.animation_player.animation_finished.disconnect(
#		_on_jump_return
#	)
#	current_move_info["resume_timers"].call()
