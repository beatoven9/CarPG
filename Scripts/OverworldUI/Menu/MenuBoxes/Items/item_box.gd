extends MarginContainer

signal go_back

@onready var tab_container = $VBoxContainer/ItemTabs
@onready var all_items_list = $VBoxContainer/ItemTabs.get_node("All Items").get_node("ItemList")
@onready var tab_list = tab_container.get_children()

func activate_box():
	tab_container.set_current_tab(0)
	all_items_list.grab_focus()
	all_items_list.select(0)

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
		#print("Handling input")
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
		# print("Not handling input")

func focus_tab(index):
	tab_container.set_current_tab(index)
	var current_tab = tab_list[index]
	current_tab.get_node("ItemList").select(0)
	current_tab.get_node("ItemList").grab_focus.call_deferred()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

