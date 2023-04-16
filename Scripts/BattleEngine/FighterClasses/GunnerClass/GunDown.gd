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
var rotation_delta

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
	var user = move_info["user"]
	var target = move_info["target"]
	var fighter_attack = user.fighter_attack
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
		damage_output = fighter_attack + move_base_power + weapon_bonus
	elif move_base_power == 0:
		damage_output = 0

	if crit:
		damage_output += weapon_bonus

	move_info["success"] = calculate_move_success(move_info, success_roll)
	move_info["move_power"] = damage_output
	move_info["critical"] = crit

	user.gunner_attack_anims.animation_looped.connect(
		_on_shot_complete
	)

	rotation_delta = user.position.angle_to_point(target.position)
	user.rotation += rotation_delta

	user.gunner_attack_anims.set_visible(true)
	user.gunner_attack_anims.play("gun_down_shot")
	target.gunner_attack_anims.set_visible(true)
	target.gunner_attack_anims.play("gun_down_hit")
	target.receive_move(current_move_info)

	return move_info

func _on_shot_complete():
	var user = current_move_info["user"]	
	var target = current_move_info["target"]	

	user.gunner_attack_anims.set_visible(false)
	user.gunner_attack_anims.stop()
	target.gunner_attack_anims.set_visible(false)
	target.gunner_attack_anims.stop()

	user.rotation -= rotation_delta
	user.gunner_attack_anims.animation_looped.disconnect(
		_on_shot_complete
	)

	var announcement = generate_announcement_string(current_move_info)
	current_move_info["announcer_box"].make_announcement(
		announcement
	)
	current_move_info["resume_timers"].call()
