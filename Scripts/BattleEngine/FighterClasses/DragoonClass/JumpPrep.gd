extends base_move
class_name JUMP_PREP

var move_name = "Jump"
var base_power = 0
var move_type = "jump_prep"
var sub_selection = []
var friendly = false
var bp_cost = 10
var crit_rate = .25
var steal_item = false
var next_move = JUMP.new()

var jump_template_strings = [
	"-{USER} jumped up so high.",
	"-{USER} sprung into the air.",
	"-{USER} leapt into the sky.",
]

func generate_announcement_string(move_info):
	var new_announcement = jump_template_strings.pick_random().replace(
		"{USER}",
		move_info["user"].fighter_name
	)
	return new_announcement

