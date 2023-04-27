extends Node2D
class_name PartyMember

var portrait: Texture2D
var char_name: String = "default name"

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

var stats_dict = {
	"attack": 100,
	"defense": 100,
	"magic": 100,
	"magic_defense": 100,
	"speed": 100
}

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

var class_proficiencies = {
	"Dragoon": 0,
	"Monk": 0,
	"Thief": 0,
	"Gunner": 0,
	"BlackMage": 0,
	"WhiteMage": 0,
}

func get_portrait():
	return portrait

func get_char_name():
	return char_name

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

func get_class_proficiencies():
	return class_proficiencies

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

func set_char_name(new_name):
	char_name = new_name

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
	class_proficiencies[class_string] = value

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

func get_abilities_list():
	return ["Ability 1", "Ability 2"]

func get_magic_list():
	return ["Spell 1", "Spell 2"]

func get_ring_boosts():
	return ["Fire Boost 2", "Attack Boost"]
