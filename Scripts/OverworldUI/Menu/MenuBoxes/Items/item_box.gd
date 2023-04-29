extends MarginContainer

signal go_back

@onready var tab_container = $VBoxContainer/ItemTabs

@onready var all_items_tab = tab_container.get_node("All Items")
@onready var battle_items_tab = tab_container.get_node("Battle")
@onready var restoration_items_tab = tab_container.get_node("Restoration")
@onready var equipment_items_tab = tab_container.get_node("Equipment")
@onready var key_items_tab = tab_container.get_node("Key Items")

@onready var tab_list = tab_container.get_children()

func activate_box():
	populate_item_tabs()
	tab_container.set_current_tab(0)
	all_items_tab.item_list.grab_focus()
	all_items_tab.item_list.select(0)

func item_box_focused():
	for tab in tab_list:
		if tab.get_node("ItemList").has_focus():
			return true
	return false


func select_box():
	set_visible(true)
	tab_container.set_current_tab(0)

func _input(event):
	if item_box_focused():
		if event.is_action_pressed("hotbar-1"):
			focus_tab(0)
		elif event.is_action_pressed("hotbar-2"):
			focus_tab(1)
		elif event.is_action_pressed("hotbar-3"):
			focus_tab(2)
		elif event.is_action_pressed("hotbar-4"):
			focus_tab(3)
		elif event.is_action_pressed("hotbar-5"):
			focus_tab(4)
		elif event.is_action_pressed("ui_cancel"):
			tab_container.set_current_tab(0)
			go_back.emit()
			accept_event()
		elif event.is_action_pressed("next_tab"):
			if tab_container.current_tab < len(tab_list) - 1:
				focus_tab(tab_container.current_tab + 1)
		elif event.is_action_pressed("previous_tab"):
			if tab_container.current_tab > 0:
				focus_tab(tab_container.current_tab - 1)
	else:
		pass

func focus_tab(index):
	tab_container.set_current_tab(index)
	var current_tab = tab_list[index]
	current_tab.get_node("ItemList").select(0)
	current_tab.get_node("ItemList").grab_focus.call_deferred()

func populate_item_tabs():
	all_items_tab.populate_list(GlobalInventory.get_all_items())
	battle_items_tab.populate_list(GlobalInventory.get_battle_items())
	restoration_items_tab.populate_list(GlobalInventory.get_restoration_items())
	equipment_items_tab.populate_list(GlobalInventory.get_equipment())
	key_items_tab.populate_list(GlobalInventory.get_key_items())
