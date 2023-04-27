extends "res://Scripts/OverworldUI/Menu/MenuBoxes/Equipment/EquipmentSlotBase.gd"
class_name RingSlot

var popup_options = [
	"Equip",
	"Unequip",
	"Move",
	"Change Mode",
	"Cancel"
]

var mode_popup_options = [
	"offense",
	"defense",
	"tactical"
]

var mode_popup: PopupMenu

func _init():
	equip_type = EQUIP_TYPES.RING

func _ready():
	super._ready()


func _handle_slot_pressed():
	popup = generic_popup.instantiate()
	popup.add_item(popup_options[0])
	popup.add_item(popup_options[1])
	popup.add_item(popup_options[2])

	mode_popup = generic_popup.instantiate()
	for mode in mode_popup_options:
		mode_popup.add_item(mode)
	mode_popup.set_name("mode_popup")

	popup.add_child(mode_popup)
	popup.add_submenu_item("Change Mode", "mode_popup")

	add_child(popup)
	popup.set_visible(true)
	popup.set_position(global_position)
	popup.set_focused_item(0)
	popup.grab_focus()

	popup.index_pressed.connect(_handle_popup_response)
	mode_popup.index_pressed.connect(_handle_mode_change_response)

	# request_new_equip.connect()	


func _handle_popup_response(index):
	var selected = popup_options[index]
	var callback = {
		"Equip": _handle_equip_request,
		"Unequip": _handle_unequip_request,
		"Move": _handle_move_request,
		"Cancel": _handle_cancel_request
	}[selected]

	callback.call()
	popup.queue_free()

func _handle_equip_request():
	super._handle_equip_request()

func _handle_mode_change_response(index):
	var selected = mode_popup_options[index]
	print(selected)
