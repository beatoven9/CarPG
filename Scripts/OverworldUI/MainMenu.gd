extends ItemList

var item_selected_idx = 0

func _gui_input(event):
	if event.is_action_pressed("ui_down"):
		item_selected_idx += 1
		select(item_selected_idx)
		item_selected.emit(item_selected_idx)
	elif event.is_action_pressed("ui_up"):
		item_selected_idx -= 1
		select(item_selected_idx)
		item_selected.emit(item_selected_idx)
	elif event.is_action_pressed("ui_accept") || event.is_action_pressed("ui_right"):
		item_activated.emit(item_selected_idx)
	accept_event()

func select_item(idx):
	select(idx)
	item_selected_idx = idx
	item_selected.emit(item_selected_idx)

