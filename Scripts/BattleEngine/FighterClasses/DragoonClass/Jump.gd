extends base_move
class_name JUMP

var move_name = "Jump"
var base_power = 90
var move_type = "jump_attack"
var sub_selection = []
var friendly = false
var bp_cost = 10
var crit_rate = .25
var steal_item = false

var jump_template_strings = [
	"{USER} jumped up so high.",
	"{USER} sprung into the air.",
	"{USER} leapt into the sky.",
]

func generate_announcement_string(move_info):
	if move_info["wait"] == true:
		var new_announcement = jump_template_strings.pick_random().replace(
			"{USER}",
			move_info["user"].fighter_name
		)
		return new_announcement

	else:
		return super.generate_announcement_string(move_info)
