extends MarginContainer
class_name BaseItem

var name_string = "equipment name"
var description = "default description. set it with the set_description(text) method"
var effect = "default effect string"

func get_name_string():
	return name_string

func set_name_string(new_name: String):
	name_string = new_name

func set_description(new_text: String):
	description = new_text

func get_description():
	return description

func set_effect(new_text: String):
	effect = new_text

func get_effect():
	return effect
