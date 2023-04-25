extends ItemList

var item_selected_idx = 0

signal close_menu

func _gui_input(event):
	if event.is_action_pressed("ui_down"):
		if item_selected_idx < get_item_count() - 1:
			item_selected_idx += 1
			select(item_selected_idx)
			item_selected.emit(item_selected_idx)
			accept_event()
	elif event.is_action_pressed("ui_up"):
		if item_selected_idx > 0:
			item_selected_idx -= 1
			select(item_selected_idx)
			item_selected.emit(item_selected_idx)
			accept_event()
	elif event.is_action_pressed("ui_accept") || event.is_action_pressed("ui_right"):
		item_activated.emit(item_selected_idx)
		accept_event()
	elif event.is_action_pressed("ui_cancel"):
		close_menu.emit()
		accept_event()

func select_item(idx):
	select(idx)
	item_selected_idx = idx
	item_selected.emit(item_selected_idx)

