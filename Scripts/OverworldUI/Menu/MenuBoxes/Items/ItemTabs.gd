extends TabContainer


func item_box_focused():
	for tab in get_children():
		if tab.get_node("ItemList").has_focus():
			return true
	return false

func focus_tab(index):
	set_current_tab(index)
	get_children()[current_tab].get_node("ItemList").select(0)
	get_children()[current_tab].get_node("ItemList").grab_focus.call_deferred()

