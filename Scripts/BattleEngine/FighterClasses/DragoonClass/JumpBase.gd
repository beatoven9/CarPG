extends base_move
class_name JumpBase

var current_move_info 
var user_original_x_position
var user_original_y_position

func use_move(
	move_info,
	success_roll,
	crit_roll
):
	var user = move_info["user"]
	current_move_info = move_info
	user_original_x_position = user.position.x
	user_original_y_position = user.position.y
	use_jump_attack(
		move_info,
		success_roll,
		crit_roll
	)


func use_jump_attack(move_info, success_roll, crit_roll):
	var user = move_info["user"]
	var target = move_info["target"]
	user.position.x = target.position.x
	var y_displacement = user.position.y - target.position.y
	user.position.y -= y_displacement
	move_info = use_physical_attack(
		move_info,
		success_roll,
		crit_roll
	)	
	user.z_index += 1
	user.animation_player.play("jump_attack")
	user.animation_player.animation_finished.connect(
		_on_jump_complete
	)

	return move_info

func _on_jump_complete(_animation_name):
	var target = current_move_info["target"]
	var user = current_move_info["user"]
	target.receive_move(current_move_info)
	user.animation_player.animation_finished.disconnect(
		_on_jump_complete
	)
	var announcement = generate_announcement_string(current_move_info)
	current_move_info["announcer_box"].make_announcement(
		announcement
	)
	user.position.x = user_original_x_position
	user.position.y = user_original_y_position
	user.z_index -= 1	

	user.animation_player.animation_finished.connect(
		_on_jump_return
	)
	user.animation_player.play("jump_return")

func _on_jump_return(_animation_name):
	var user = current_move_info["user"]
	user.animation_player.animation_finished.disconnect(
		_on_jump_return
	)
	current_move_info["resume_timers"].call()
