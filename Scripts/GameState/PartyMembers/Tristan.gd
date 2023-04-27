extends PartyMember
class_name Tristan

var local_portrait: Texture2D = preload("res://Sprites/UI_Sprites/Portraits/TristanPortrait_32.png")
var local_name_string = "Tristan"

var local_base_stats_dict = {
	"attack": 15,
	"defense": 5,
	"magic": 5,
	"magic_defense": 5,
	"speed": 10
}

var local_stat_increase_scale_dict = {
	"attack": 3,
	"defense": 1,
	"magic": 1,
	"magic_defense": 1,
	"speed": 2
}


func _init():
	set_portrait(local_portrait)
	set_name_string(local_name_string)
	set_stat_increase_scale_dict(local_stat_increase_scale_dict)
	set_base_stats_dict(local_base_stats_dict)


	##### Testing
	set_class_stone(BlackMageStone.new())
	set_weapon(StandardSword.new())
	set_current_exp(52)
	set_class_proficiency("black_mage", 10)
