extends BaseEquipment
class_name BaseEquipmentLevelable

# var current_level = 1
var current_exp = 0

var level_tiers = [
	50,
	100,
	200,
	350,
	500
]

func set_current_exp(num: int):
	current_exp = num

func get_level():
	var current_level = 0
	for i in range(len(level_tiers)):
		if current_exp < level_tiers[i]:
			return current_level
		else:
			current_level += 1

func get_current_exp():
	return current_exp

func get_exp_to_next_level():
	var current_level = get_level()
	var next_level = current_level + 1
	var next_level_idx = next_level - 1

	var exp_to_next_level = level_tiers[next_level_idx] - get_current_exp()
	return exp_to_next_level
