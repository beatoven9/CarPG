extends base_move
class_name JumpPrepBase

var current_move_info

func use_move(
	move_info,
	success_roll,
	crit_roll
):
	current_move_info = move_info
	var move = move_info["move"]
	var move_type = move.move_type

	move_info = use_jump_prep(
		move_info,
		success_roll,
		crit_roll
	)

	return move_info

func use_jump_prep(move_info, success_roll, crit_roll):
	var user = move_info["user"]
	user.jumped = true

	push_next_move(move_info)

	user.animation_player.play("jump_prep")

	move_info["success"] = calculate_move_success(
		move_info,
		success_roll
	)

	if move_info["success"]:
		move_info["on_move_complete"].call()			
		var announcement_string = move_info["move"].generate_announcement_string(move_info)
		move_info["announcer_box"].make_announcement(announcement_string)

func push_next_move(move_info):
	print("This method is here to be overridden")
