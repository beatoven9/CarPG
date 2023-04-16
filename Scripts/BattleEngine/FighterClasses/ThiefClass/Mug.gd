extends StealBase
class_name MUG

var move_name = "Mug"
var base_power = 90
var move_type = "melee_attack"
var sub_selection = []
var friendly = false
var bp_cost = 10
var crit_rate = .25
var steal_item = true


var attempt_templates = [
	"{USER} attempted to mug {TARGET}.",
	"{USER} tried to mug {TARGET}."
]

var steal_success_templates = [
	"\nHe stole {STOLEN_ITEM}.",
]

var steal_failure_templates = [
	"\nBut it was unsuccessful",
	"\nNothing happened"
]

func generate_announcement_string(move_info):
	var user = move_info["user"]
	var target = move_info["target"]
	var stolen_item = move_info["stolen_item"]
	var critical = move_info["critical"]
	var damage_output = move_info["move_power"]
	var damage_incurred = move_info["damage_incurred"]

	var selected_template = attempt_templates.pick_random()
	var announcement_string = selected_template.replace(
		"{USER}",
		user.fighter_name
	).replace(
		"{TARGET}",
		target.fighter_name
	)
	if len(stolen_item) > 0:
		announcement_string += steal_success_templates.pick_random().replace( 
			"{STOLEN_ITEM}",
			stolen_item
		)

	elif len(stolen_item) == 0:
		announcement_string += steal_failure_templates.pick_random()

	return announcement_string
