extends BaseMagicRestorationItem
class_name Ether

var local_name_string = "Ether"
var local_restoration_amount = 10
var local_description = "This item restores 10 mp."
var local_effect = "Magic Restoration"

func _init():
	set_name_string(local_name_string)
	set_restoration_amount(local_restoration_amount)
	set_description(local_description)
	set_effect(local_effect)
