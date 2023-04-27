extends PartyMember
class_name Wedge

@onready var local_portrait: Texture2D = preload("res://Sprites/UI_Sprites/Portraits/GearsonPortrait_32.png")
var local_name_string = "Wedge"

var local_base_stats_dict = {
	"attack": 5,
	"defense": 5,
	"magic": 15,
	"magic_defense": 10,
	"speed": 10
}

var local_stat_increase_scale_dict = {
	"attack": 1,
	"defense": 1,
	"magic": 2,
	"magic_defense": 2,
	"speed": 2
}


func _init():
	set_portrait(local_portrait)
	set_name_string(local_name_string)
	set_stat_increase_scale_dict(local_stat_increase_scale_dict)
	set_base_stats_dict(local_base_stats_dict)


	###### Testing
	set_class_stone(BlackMageStone.new())
	set_current_exp(243)
	set_class_proficiency("black_mage", 100)
