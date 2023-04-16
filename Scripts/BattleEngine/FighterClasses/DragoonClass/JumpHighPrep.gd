extends JumpPrepBase
class_name JUMP_HIGH_PREP

var move_name = "Jump High"
var base_power = 0
var move_type = "jump_prep"
var sub_selection = []
var friendly = false
var bp_cost = 10
var crit_rate = .25
var steal_item = false
var next_move = JUMP_HIGH.new()

var jump_template_strings = [
	"-{USER} jumped up so so so high.",
	"-{USER} sprung suuuper high into the air.",
	"-{USER} leapt realllly high into the sky.",
]

func generate_announcement_string(move_info):
	var new_announcement = jump_template_strings.pick_random().replace(
		"{USER}",
		move_info["user"].fighter_name
	)
	return new_announcement

func push_next_move(move_info):
	var user = move_info["user"]
	var jump_attack = user.gen_move_info(
		next_move,
		move_info["user"],
		move_info["target"],
	)
	user.move_queue.push_back(
		jump_attack
	)

