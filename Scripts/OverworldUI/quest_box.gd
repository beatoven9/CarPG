extends MarginContainer

@onready var quest_list: ItemList = $VBoxContainer/QuestListContainer/MarginContainer/QuestList

func _ready():
	pass

func activate_box():
	quest_list.select(0)
	quest_list.grab_focus()

