extends JumpBase
class_name JUMP_HIGH

var move_name = "Jump High"
var base_power = 90
var move_type = "jump_attack"
var sub_selection = []
var friendly = false
var bp_cost = 0
var crit_rate = .25
var steal_item = false

var jump_template_strings = [
	"-{USER} fell from high in the sky on top of {TARGET}",
	"-{USER} slammed from really high onto {TARGET}",
	"-{USER} leapt from way high up onto {TARGET}",
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
