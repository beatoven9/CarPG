extends PartyMember
class_name GovGearson

@onready var local_portrait: Texture2D = preload("res://Sprites/UI_Sprites/Portraits/GearsonPortrait_32.png")

var base_stats_dict = {
	"attack": 10,
	"defense": 10,
	"magic": 5,
	"magic_defense": 5,
	"speed": 10
}

var local_stats_dict = {

}

var stat_increase_scale_dict = {
	"attack": 2,
	"defense": 2,
	"magic": 1,
	"magic_defense": 1,
	"speed": 2
}

func level_up():
	var current_level = get_level()
	var stat_increase_dict = {}
	for key in stat_increase_scale_dict.keys():
		stat_increase_dict[key] = stat_increase_dict[key] * current_level

	for key in stats_dict.keys():
		stats_dict[key] += stat_increase_dict[key]

func _init():
	set_portrait(local_portrait)

