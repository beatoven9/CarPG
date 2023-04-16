extends base_move
class_name RAM

var move_name = "Ram"
var base_power = 90
var move_type = "melee_attack"
var sub_selection = []
var friendly = false
var bp_cost = 0
var crit_rate = .25
var steal_item = false

var current_move_info
var rotation_delta

func use_move(
	move_info,
	success_roll,
	crit_roll
):
	current_move_info = move_info
	var move = move_info["move"]
	var move_type = move.move_type

	move_info = use_ram_attack(
		move_info,
		success_roll,
		crit_roll
	)

	return move_info

func use_ram_attack(move_info, success_roll, crit_roll):
	var user = move_info["user"]
	var target = move_info["target"]
	rotation_delta = user.position.angle_to_point(target.position)
	user.rotation += rotation_delta
	move_info = use_physical_attack(
		move_info,
		success_roll,
		crit_roll
	)	
	user.z_index += 1
	user.animation_player.play("ram_attack")
	user.animation_player.animation_finished.connect(
		_on_ram_complete
	)

	return move_info

func _on_ram_complete(_animation_name):
	var target = current_move_info["target"]
	var user = current_move_info["user"]
	target.receive_move(current_move_info)
	user.animation_player.animation_finished.disconnect(
		_on_ram_complete
	)
	var announcement = generate_announcement_string(current_move_info)
	current_move_info["announcer_box"].make_announcement(
		announcement
	)
	user.z_index -= 1	
	user.animation_player.animation_finished.connect(
		_on_ram_return
	)
	user.rotation -= rotation_delta
	user.animation_player.play("ram_return")

func _on_ram_return(_animation_name):
	var user = current_move_info["user"]
	user.animation_player.animation_finished.disconnect(
		_on_ram_return
	)
	current_move_info["resume_timers"].call()
