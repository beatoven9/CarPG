extends BaseBattleItem
class_name Grenade

var local_name_string = "Grenade"
var local_damage_amount = 10
var local_description = "This item restores 10 mp."
var local_effect = "Magic Restoration"

func _init():
	set_name_string(local_name_string)
	set_damage_amount(local_damage_amount)
	set_description(local_description)
	set_effect(local_effect)
