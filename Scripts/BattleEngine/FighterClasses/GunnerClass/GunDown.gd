extends base_move
class_name GUN_DOWN

var move_name = "Gun Down"
var base_power = 90
var move_type = "gun_attack"
var sub_selection = []
var friendly = false
var bp_cost = 0
var crit_rate = .25
var steal_item = false

var current_move_info

var original_rotation

var current_user
var current_target

func use_move(
	move_info,
	success_roll,
	crit_roll
):
	current_move_info = move_info
	var move = move_info["move"]

	move_info = use_gun_down_attack(
		move_info,
		success_roll,
		crit_roll
	)

	return move_info

func use_gun_down_attack(move_info, success_roll, crit_roll):
	var move = move_info["move"]
	current_user = move_info["user"]
	current_target = move_info["target"]
	var fighter_attack = current_user.fighter_attack
	var weapon_bonus = current_user.weapon_bonus

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

	current_user.gunner_attack_anims.animation_looped.connect(
		_on_shot_complete
	)

	original_rotation = current_user.rotation
	var rotation_delta = current_user.position.angle_to_point(current_target.position)
	var target_rotation = original_rotation + rotation_delta
	current_user.rotate_to(target_rotation, .2, fire_shots)

	return move_info

func _on_shot_complete():

	current_user.gunner_attack_anims.set_visible(false)
	current_user.gunner_attack_anims.stop()
	current_target.gunner_attack_anims.set_visible(false)
	current_target.gunner_attack_anims.stop()

	current_user.rotate_to(original_rotation, .2, _on_move_complete)
	current_user.gunner_attack_anims.animation_looped.disconnect(
		_on_shot_complete
	)

func fire_shots():
	current_user.gunner_attack_anims.set_visible(true)
	current_user.gunner_attack_anims.play("gun_down_shot")
	current_target.gunner_attack_anims.set_visible(true)
	current_target.gunner_attack_anims.play("gun_down_hit")
	current_target.receive_move(current_move_info)

func _on_move_complete():
	var announcement = generate_announcement_string(current_move_info)
	current_move_info["announcer_box"].make_announcement(
		announcement
	)
	current_move_info["resume_timers"].call()
