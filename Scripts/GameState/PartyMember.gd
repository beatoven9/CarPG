extends Node2D
class_name PartyMember

var portrait: Texture2D
var name_string: String = "default name"

var current_exp: int = 0
var level_tiers = [
	50,
	100,
	200,
	400,
	700,
	1000,
	1500,
	2000,
	3000,
	5000,
	7000,
	10000
]

var current_hp: int = 100
var max_hp: int = 100
var current_mp: int = 100
var max_mp: int = 100

var base_stats_dict = {
	"attack": 10,
	"defense": 10,
	"magic": 5,
	"magic_defense": 5,
	"speed": 10
}

var stats_dict = {
	"attack": 100,
	"defense": 100,
	"magic": 100,
	"magic_defense": 100,
	"speed": 100
}

var stat_increase_scale_dict = {}

var status = {
	"poison": false,
	"asleep": false,
	"blind": false,
	"mute": false,
	"confused": false,
	"slow": false,
	"fast": false,
}

var equipment = {
	"class_stone": null,  # No class stone denotes a MonkClass?
	"weapon": null,
	"ring_1": {
		"mode": "offense",
		"ring": null
	},
	"ring_2": {
		"mode": "offense",
		"ring": null
	},
	"ring_3": {
		"mode": "offense",
		"ring": null
	},
}

var class_proficiency_dict = {
	"black_mage": 0,
	"dragoon": 0,
	"gunner": 0,
	"monk": 0,
	"thief": 0,
	"white_mage": 0,
}

func get_portrait():
	return portrait

func get_name_string():
	return name_string

func get_current_hp():
	return current_hp

func get_max_hp():
	return max_hp

func get_current_mp():
	return current_mp

func get_max_mp():
	return max_mp

func get_status_dict():
	return status

func get_class_stone():
	return equipment["class_stone"]

func get_class_proficiency_dict():
	return class_proficiency_dict

func get_class_proficiency(fighter_class_enum):
	var class_name_string: String

	match fighter_class_enum:
		FIGHTER_CLASSES.BLACK_MAGE:
			class_name_string = "black_mage"
		FIGHTER_CLASSES.DRAGOON:
			class_name_string = "dragoon"
		FIGHTER_CLASSES.GUNNER:
			class_name_string = "gunner"
		FIGHTER_CLASSES.MONK:
			class_name_string = "monk"
		FIGHTER_CLASSES.THIEF:
			class_name_string = "thief"
		FIGHTER_CLASSES.WHITE_MAGE:
			class_name_string = "white_mage"

	return class_proficiency_dict[class_name_string]

func get_weapon():
	return equipment["weapon"]

func get_ring_1():
	return equipment["ring_1"]["ring"]

func get_ring_1_mode():
	return equipment["ring_1"]["mode"]

func get_ring_2():
	return equipment["ring_2"]["ring"]

func get_ring_2_mode():
	return equipment["ring_2"]["mode"]

func get_ring_3():
	return equipment["ring_3"]["ring"]

func get_ring_3_mode():
	return equipment["ring_3"]["mode"]



func set_portrait(new_portrait):
	portrait = new_portrait

func set_name_string(new_name):
	name_string = new_name

func set_current_hp(hp):
	current_hp = hp

func set_max_hp(hp):
	max_hp = hp

func set_current_mp(mp):
	current_mp = mp

func set_max_mp(mp):
	max_mp = mp

func set_status(status_string, value):
	status[status_string] = value

func set_class_stone(new_stone):
	equipment["class_stone"] = new_stone

func set_class_proficiency(class_string, value):
	class_proficiency_dict[class_string] = value

func set_class_proficiency_dict(new_dict):	
	class_proficiency_dict = new_dict

func set_weapon(weapon):
	equipment["weapon"] = weapon

func set_ring_1(ring):
	equipment["ring_1"]["ring"] = ring

func set_ring_1_mode(new_mode):
	equipment["ring_1"]["mode"] = new_mode

func set_ring_2(ring):
	equipment["ring_2"]["ring"] = ring

func set_ring_2_mode(new_mode):
	equipment["ring_2"]["mode"] = new_mode

func set_ring_3(ring):
	equipment["ring_3"]["ring"] = ring

func set_ring_3_mode(new_mode):
	equipment["ring_3"]["mode"] = new_mode

func set_stat_increase_scale_dict(new_dict):
	stat_increase_scale_dict = new_dict

func get_level():
	var current_level = 0
	for i in range(len(level_tiers)):
		if current_exp < level_tiers[i]:
			return current_level
		else:
			current_level += 1
	return current_level

func set_current_exp(value: int):
	current_exp = value

func add_exp(value: int):
	current_exp += value

func get_current_exp():
	return current_exp

func get_available_moves():
	var class_stone = get_class_stone()

	var available_moves: AvailableMoves = get_class_stone().get_available_moves(
		get_class_proficiency(class_stone.fighter_class)
	)
	return available_moves

func get_exp_to_next_level():
	var current_level = get_level()
	var next_level = current_level + 1
	var next_level_idx = next_level - 1

	var exp_to_next_level = level_tiers[next_level_idx] - get_current_exp()
	return exp_to_next_level

func get_abilities_list():
	return ["Ability 1", "Ability 2"]

func get_magic_list():
	return ["Spell 1", "Spell 2"]

func get_ring_boosts():
	return ["Fire Boost 2", "Attack Boost"]

func level_up():
	var current_level = get_level()
	var stat_increase_dict = {}
	for key in stat_increase_scale_dict.keys():
		stat_increase_dict[key] = stat_increase_dict[key] * current_level

	for key in stats_dict.keys():
		stats_dict[key] += stat_increase_dict[key]

func get_stats_dict():
	return calculate_stats_dict()

func set_base_stats_dict(new_dict):
	base_stats_dict = new_dict

func calculate_stats_dict():
	var new_stats_dict = {}

	for key in base_stats_dict.keys():
		new_stats_dict[key] = base_stats_dict[key] + (get_level() * stat_increase_scale_dict[key])
	return new_stats_dict
