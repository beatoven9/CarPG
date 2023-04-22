extends Node2D
class_name PartyMember

var portrait: Texture2D
var char_name: string

var current_hp: int
var max_hp: int
var current_mp: int
var max_mp: int

var status: dict = {
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
	"offense_ring": null,
	"defense_ring": null,
	"tactical_ring": null,
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

func get_weapon():
	return equipment["weapon"]

func get_offense_ring():
	return equipment["offense_ring"]

func get_defense_ring():
	return equipment["defense_ring"]

func get_tactical_ring():
	return equipment["tactical_ring"]



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

func set_status(status_dict):
	status = status_dict

func set_weapon(weapon):
	equipment["weapon"] = weapon

func set_offense_ring(ring):
	equipment["offense_ring"] = ring

func set_defense_ring(ring):
	equipment["defense_ring"] = ring

func set_tactical_ring(ring):
	equipment["weapon"] = ring
