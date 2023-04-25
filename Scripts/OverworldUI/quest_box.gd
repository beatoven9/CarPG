extends MarginContainer

signal go_back
@onready var quest_list: ItemList = $VBoxContainer/QuestListContainer/MarginContainer/QuestList

func _input(event):
	if quest_list.has_focus():
		if event.is_action_pressed("ui_cancel"):
			go_back.emit()

func _ready():
	pass

func activate_box():
	quest_list.select(0)
	quest_list.grab_focus()

