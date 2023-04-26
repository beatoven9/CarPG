extends Node2D
class_name PartyMember

var portrait: Texture2D
var char_name: String

var current_hp: int
var max_hp: int
var current_mp: int
var max_mp: int

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
