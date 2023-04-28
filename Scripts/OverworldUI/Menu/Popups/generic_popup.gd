extends PopupMenu
class_name GenericPopup

var popup_options: Array

signal response(str)

func _ready():
	index_pressed.connect(_handle_response)

func set_items(item_list):
	popup_options = []
	for item in item_list:
		popup_options.append(item)
		add_item(item)

func _handle_response(idx):
	response.emit(popup_options[idx])
	queue_free()
