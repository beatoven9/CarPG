extends BaseHealthRestorationItem
class_name Potion

var local_name_string = "Potion"
var local_restoration_amount = 10
var local_description = "This item restores 10 hp."
var local_effect = "Health Restoration"

func _init():
	set_name_string(local_name_string)
	set_restoration_amount(local_restoration_amount)
	set_description(local_description)
	set_effect(local_effect)

