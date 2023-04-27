extends PartyMember
class_name GovGearson

@onready var local_portrait: Texture2D = preload("res://Sprites/UI_Sprites/Portraits/GearsonPortrait_32.png")
var local_name_string = "Gov. Gearson"

var local_base_stats_dict = {
	"attack": 10,
	"defense": 10,
	"magic": 5,
	"magic_defense": 5,
	"speed": 10
}

var local_stat_increase_scale_dict = {
	"attack": 2,
	"defense": 2,
	"magic": 1,
	"magic_defense": 1,
	"speed": 2
}

var local_class_proficiency_dict = {
	"black_mage": 0,
	"dragoon": 0,
	"gunner": 0,
	"monk": 0,
	"thief": 0,
	"white_mage": 0
}


func _init():
	set_portrait(local_portrait)
	set_name_string(local_name_string)
	set_stat_increase_scale_dict(local_stat_increase_scale_dict)
	set_base_stats_dict(local_base_stats_dict)
	set_class_proficiency_dict(local_class_proficiency_dict)


	##### Testing
	set_class_stone(BlackMageStone.new())
	set_current_exp(1000)
	set_class_proficiency("black_mage", 400)
