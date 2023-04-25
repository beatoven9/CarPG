extends MarginContainer

signal go_back
@onready var quest_item_list: ItemList = $VBoxContainer/QuestListContainer/MarginContainer/QuestList
@onready var quest_description_label: Label = $VBoxContainer/QuestDescriptionContainer/MarginContainer/QuestDescription

var quest1 = {
	"quest_name": "quest1",
	"quest_description": "This quest will not be hard. Just collect some gumballs."
}
var quest2 = {
	"quest_name": "quest2",
	"quest_description": "This quest will be hard. Collect 1,000,000 gumballs."
}
var quest3 = {
	"quest_name": "quest3",
	"quest_description": "This quest will be really hard. Eat all of the 1,000,000 gumballs."
}

var quest_list = [quest1, quest2, quest3]

func _input(event):
	if quest_item_list.has_focus():
		if event.is_action_pressed("ui_cancel"):
			go_back.emit()
			accept_event()

func _ready():
	populate_box(quest_list)
	quest_item_list.item_selected.connect(_on_quest_selected)

func activate_box():
	quest_item_list.select(0)
	update_description(quest_list[0]["quest_description"])
	quest_item_list.grab_focus()

func populate_box(quest_data_list):
	for quest in quest_data_list:
		quest_item_list.add_item(quest["quest_name"])

func _on_quest_selected(idx):
	var new_text = quest_list[idx]["quest_description"]
	update_description(new_text)

func update_description(text):
	quest_description_label.set_text(text)

func select_box():
	set_visible(true)
