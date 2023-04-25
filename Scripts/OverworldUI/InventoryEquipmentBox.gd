extends ItemList

signal cancel_inventory_box

func _gui_input(event):
	if event.is_action_pressed("ui_cancel"):
		cancel_inventory_box.emit()
