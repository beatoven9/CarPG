extends base_move
class_name CURE

var move_name = "Cure"
var base_power = 90
var move_type = "white_magic_healing"
var friendly = false
var elemental_damage = null
var bp_cost = 10
var crit_rate = 1.0
var steal_item = false

var healing_attempt_templates = [
	"-{USER} cast {MOVE} on {TARGET}"
]

var healing_result_templates = [
	"-{TARGET} gained {DAMAGE_INCURRED} hp",
	"-{TARGET} was healed by {DAMAGE_INCURRED} hp",
]


func generate_announcement_string(move_info):

	var move = move_info["move"]
	var user = move_info["user"]
	var target = move_info["target"]
	var stolen_item = move_info["stolen_item"]
	var critical = move_info["critical"]
	var damage_output = move_info["move_power"]
	var damage_incurred = move_info["damage_incurred"]

	var selected_template = healing_attempt_templates.pick_random()
	var announcement_string = selected_template.replace(
		"{USER}",
		user.fighter_name
	).replace(
		"{TARGET}",
		target.fighter_name
	).replace(
		"{MOVE}",
		move.move_name	
	)
	var damage_string

	if move_info["success"] == false:
		damage_string = generate_failure_string()
	elif damage_incurred < 0:
		damage_string = generic_damage_templates.pick_random().replace(
			"{TARGET}",
			target.fighter_name
		).replace(
			"{DAMAGE_INCURRED}",
			str(damage_incurred)
		)

	elif damage_incurred > 0:
		damage_string = generic_healing_templates.pick_random().replace(
			"{TARGET}",
			target.fighter_name
		).replace(
			"{DAMAGE_INCURRED}",
			str(damage_incurred)
		)

	announcement_string += "\n\n" + damage_string

	return announcement_string
