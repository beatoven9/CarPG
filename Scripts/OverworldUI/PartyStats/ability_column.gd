extends VBoxContainer

@onready var ability_label = preload("res://Scenes/Overworld_UI/PartyStats/ability_label.tscn")


func create_column(abilities):
	for ability in abilities:
		var new_label = ability_label.instantiate()
		new_label.set_text(ability)
		add_child(new_label)
