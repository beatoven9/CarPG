extends base_move
class_name StealBase

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

	move_info = use_steal_attack(
		move_info,
		success_roll,
		crit_roll
	)

	return move_info

func use_steal_attack(move_info, success_roll, crit_roll):
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
		_on_steal_complete
	)

	if move_info["success"]:
		move_info["stolen_item"] = barter_steal(user, target)

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
	var user = current_move_info["user"]
	target.receive_move(current_move_info)
	user.animation_player.animation_finished.disconnect(
		_on_steal_complete
	)
	var announcement = generate_announcement_string(current_move_info)
	current_move_info["announcer_box"].make_announcement(
		announcement
	)
	user.z_index -= 1	
	user.animation_player.animation_finished.connect(
		_on_steal_return
	)
	user.rotation -= rotation_delta
	user.animation_player.play("ram_return")

func _on_steal_return(_animation_name):
	var user = current_move_info["user"]
	user.animation_player.animation_finished.disconnect(
		_on_steal_return
	)
	current_move_info["resume_timers"].call()
