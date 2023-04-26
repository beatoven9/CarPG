extends MarginContainer

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

var main_menu_options = ["Party", "Items",  "Equipment", "Quests", "Exit"]

func _ready():
	populate_main_menu()
	main_menu.item_selected.connect(_on_main_menu_selection)
	main_menu.item_activated.connect(_on_main_menu_activated)

	main_menu.close_menu.connect(close_menu)
	party_box.go_back.connect(main_menu.grab_focus)
	item_box.go_back.connect(main_menu.grab_focus)
	equipment_box.go_back.connect(main_menu.grab_focus)
	quest_box.go_back.connect(main_menu.grab_focus)


func populate_boxes(_ui_data):
	pass

func _input(event):
	if event.is_action_pressed("menu-toggle"):
		if is_visible():
			close_menu()
			accept_event()

func get_ui_data():
	var char_1 = PartyMember.new()
	char_1.set_max_hp(100)
	char_1.set_max_mp(100)
	char_1.set_current_hp(90)
	char_1.set_current_mp(50)
	char_1.set_status("confused", true)
	char_1.set_status("poisoned", true)

	

	return {}

func open_menu():
	get_tree().paused = true
	close_boxes()

	populate_boxes(get_ui_data())

	set_visible(true)
	main_menu.grab_focus()
	main_menu.select_item(0)
	_open_party_menu()


func close_menu():
	close_boxes()
	set_visible(false)
	get_tree().paused = false


func populate_main_menu():
	for option in main_menu_options:
		main_menu.add_item(" " + option)

func _on_main_menu_selection(item_index):
	var callback = {
		"Party": _open_party_menu,
		"Items": _open_items_menu,
		"Quests": _open_quests_menu,
		"Equipment": _open_equipment_menu,
		"Exit": close_boxes
	}[main_menu_options[item_index]]

	callback.call()

func _on_main_menu_activated(item_index):
	var callback = {
		"Party": _activate_party_menu,
		"Items": _activate_items_menu,
		"Quests": _activate_quests_menu,
		"Equipment": _activate_equipment_menu,
		"Exit": close_menu
	}[main_menu_options[item_index]]

	callback.call()

func close_boxes():
	for box in main_boxes:
		box.set_visible(false)


func _open_items_menu():
	close_boxes()
	item_box.select_box()

func _open_quests_menu():
	close_boxes()
	quest_box.select_box()

func _open_equipment_menu():
	close_boxes()
	equipment_box.set_visible(true)
	equipment_box.select_box()

func _open_party_menu():
	close_boxes()
	party_box.set_visible(true)


func _activate_items_menu():
	item_box.activate_box()

func _activate_quests_menu():
	quest_box.activate_box()

func _activate_equipment_menu():
	equipment_box.activate_box()

func _activate_party_menu():
	party_box.activate_box()
