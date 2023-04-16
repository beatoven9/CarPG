extends base_move
class_name TBONE

var move_name = "T-Bone"
var base_power = 120
var move_type = "melee_attack"
var sub_selection = []
var friendly = false
var bp_cost = 0
var crit_rate = .25
var steal_item = false

var current_move_info

var original_rotation
var current_user

func use_move(
	move_info,
	success_roll,
	crit_roll
):
	current_move_info = move_info
	current_user = move_info["user"]
	var move = move_info["move"]

	move_info = use_ram_attack(
		move_info,
		success_roll,
		crit_roll
	)

	return move_info


func use_ram_attack(move_info, success_roll, crit_roll):
	var target = move_info["target"]

	var rotation_delta = current_user.position.angle_to_point(target.position)

	original_rotation = current_user.rotation
	var target_rotation = original_rotation + rotation_delta
	current_user.rotate_to(target_rotation, .2, move_toward_anim)

	move_info = use_physical_attack(
		move_info,
		success_roll,
		crit_roll
	)	
	return move_info

func _on_ram_complete(_animation_name):
	var target = current_move_info["target"]
	target.receive_move(current_move_info)
	current_user.animation_player.animation_finished.disconnect(
		_on_ram_complete
	)
	var announcement = generate_announcement_string(current_move_info)
	current_move_info["announcer_box"].make_announcement(
		announcement
	)
	current_user.z_index -= 1	
	current_user.animation_player.animation_finished.connect(
		_on_ram_return
	)

	current_user.rotate_to(original_rotation, .2, empty_callback)

	current_user.animation_player.play("ram_return")

func _on_ram_return(_animation_string):
	print("RAM RETURN")
	current_user.animation_player.animation_finished.disconnect(
		_on_ram_return
	)
	current_move_info["resume_timers"].call()

func move_toward_anim():
	current_user.z_index += 1
	current_user.animation_player.play("ram_attack")
	current_user.animation_player.animation_finished.connect(
		_on_ram_complete
	)
