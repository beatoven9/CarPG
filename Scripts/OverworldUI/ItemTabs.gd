extends TabContainer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func item_box_focused():
	for tab in get_children():
		if tab.get_node("ItemList").has_focus():
			return true
	return false

func _gui_input(event):
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

func focus_tab(index):
	set_current_tab(index)
	# var current_tab = get_children()[index]
	get_children()[current_tab].get_node("ItemList").select(0)
	get_children()[current_tab].get_node("ItemList").grab_focus.call_deferred()

