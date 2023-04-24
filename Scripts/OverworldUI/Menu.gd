extends MarginContainer

var menu_open = false
@onready var main_menu = $MarginContainer/HBoxContainer/MainMenuContainer/MarginContainer/MainMenu
@onready var party_box = $MarginContainer/HBoxContainer/MainBoxContainer/MainBoxes/PartyBox
@onready var item_box = $MarginContainer/HBoxContainer/MainBoxContainer/MainBoxes/ItemBox
@onready var equipment_box = $MarginContainer/HBoxContainer/MainBoxContainer/MainBoxes/EquipmentBox
@onready var quest_box = $MarginContainer/HBoxContainer/MainBoxContainer/MainBoxes/QuestBox

@onready var main_boxes = [
	party_box,
	item_box,
	equipment_box,
	quest_box
]

var main_menu_options = ["Party", "Items",  "Equipment", "Magic", "Quests", "Exit"]

func _ready():
	populate_main_menu()
	main_menu.item_selected.connect(_on_main_menu_selection)
	main_menu.item_activated.connect(_on_main_menu_activated)

func toggle_menu():
	if menu_open == true:
		close_menu()
	elif menu_open == false:
		open_menu()


func open_menu():
	close_boxes()
	set_visible(true)
	main_menu.grab_focus()
	main_menu.select(0)
	menu_open = true
	_open_party_menu()


func close_menu():
	close_boxes()
	set_visible(false)
	menu_open = false

func populate_main_menu():
	for option in main_menu_options:
		main_menu.add_item(" " + option)

func _on_main_menu_selection(item_index):
	var callback = {
		"Party": _open_party_menu,
		"Items": _open_items_menu,
		"Quests": _open_quests_menu,
		"Equipment": _open_equipment_menu,
		"Magic": _open_magic_menu,
		"Exit": close_boxes
	}[main_menu_options[item_index]]

	callback.call()

func _on_main_menu_activated(item_index):
	var callback = {
		"Party": _activate_party_menu,
		"Items": _activate_items_menu,
		"Quests": _activate_quests_menu,
		"Equipment": _activate_equipment_menu,
		"Magic": _activate_magic_menu,
		"Exit": close_menu
	}[main_menu_options[item_index]]

	callback.call()

func close_boxes():
	for box in main_boxes:
		box.set_visible(false)


func _open_items_menu():
	close_boxes()
	item_box.set_visible(true)

func _open_quests_menu():
	close_boxes()
	quest_box.set_visible(true)

func _open_equipment_menu():
	close_boxes()
	equipment_box.set_visible(true)
	equipment_box.select_box()

func _open_magic_menu():
	pass

func _open_party_menu():
	close_boxes()
	party_box.set_visible(true)


func _activate_items_menu():
	item_box.activate_box()

func _activate_quests_menu():
	quest_box.activate_box()

func _activate_equipment_menu():
	equipment_box.activate_box()

func _activate_magic_menu():
	pass

func _activate_party_menu():
	party_box.activate_box()