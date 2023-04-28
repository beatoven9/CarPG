extends PopupMenu
class_name SelectEquipPopup

var popup_options: Array
var obj_list: Array

signal response(obj)
signal item_selected(obj)

func _ready():
	index_pressed.connect(_handle_response)
	id_focused.connect(_handle_focus_change)

func _handle_focus_change(id):
	if popup_options[id] == "cancel":
		item_selected.emit(null)
	else:
		item_selected.emit(obj_list[id])
	

func set_items(item_list):
	popup_options = []
	obj_list = item_list
	for item in item_list:
		popup_options.append(item.name_string)
		add_item(item.name_string)

	popup_options.append("cancel")
	add_item("cancel")

	if len(item_list) > 0:
		item_selected.emit(obj_list[0])
	else:
		item_selected.emit(null)

func _handle_response(idx):
	if popup_options[idx] == "cancel":
		queue_free()
	else:
		response.emit(obj_list[idx])
	queue_free()

