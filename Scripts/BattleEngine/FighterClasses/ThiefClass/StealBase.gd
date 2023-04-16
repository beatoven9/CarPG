extends base_move
class_name StealBase

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

	move_info = use_steal_attack(
		move_info,
		success_roll,
		crit_roll
	)

	return move_info

func use_steal_attack(move_info, success_roll, crit_roll):
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
	if move_info["success"]:
		move_info["stolen_item"] = barter_steal(current_user, target)

	return move_info

func barter_steal(perp, victim):
	if len(victim.snatchable_inventory) > 0:
		var new_item = victim.snatchable_inventory.pick_random()
		var new_item_name = new_item
		perp.inventory.append(new_item)
		return new_item_name
	else:
		return ""


func _on_steal_complete(_animation_name):
	var target = current_move_info["target"]
	target.receive_move(current_move_info)
	current_user.animation_player.animation_finished.disconnect(
		_on_steal_complete
	)
	var announcement = generate_announcement_string(current_move_info)
	current_move_info["announcer_box"].make_announcement(
		announcement
	)
	current_user.z_index -= 1	
	current_user.animation_player.animation_finished.connect(
		_on_steal_return
	)
	current_user.rotate_to(original_rotation, .2, empty_callback)

	current_user.animation_player.play("ram_return")

func _on_steal_return(_animation_name):
	current_user.animation_player.animation_finished.disconnect(
		_on_steal_return
	)
	current_move_info["on_move_complete"].call()
	
func move_toward_anim():
	current_user.z_index += 1
	current_user.animation_player.play("ram_attack")
	current_user.animation_player.animation_finished.connect(
		_on_steal_complete
	)
