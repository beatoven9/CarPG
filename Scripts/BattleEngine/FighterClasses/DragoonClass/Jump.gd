extends base_move
class_name JUMP

var move_name = "Jump"
var base_power = 90
var move_type = "jump_attack"
var sub_selection = []
var friendly = false
var bp_cost = 0
var crit_rate = .25
var steal_item = false

var jump_template_strings = [
	"{USER} fell from the sky on top of {TARGET}",
	"{USER} slammed onto {TARGET}",
	"{USER} leapt onto {TARGET}",
]

func generate_announcement_string(move_info):
	var announcement = jump_template_strings.pick_random().replace(
		"{USER}",
		move_info["user"].fighter_name
	).replace(
		"{TARGET}",
		move_info["target"].fighter_name
	)
	return announcement
