extends "res://Scripts/OverworldUI/Menu/MenuBoxes/Equipment/EquipmentSlotBase.gd"
class_name WeaponSlot


var popup_options = [
	"Equip",
	"Unequip",
	"Move",
	"Cancel"
]

func _init():
	equip_type = EQUIP_TYPES.WEAPON

# Called when the node enters the scene tree for the first time.
func _ready():
	#var new_equip = StandardSword.new()
	#handle_item_equip(new_equip)
	super._ready()

func _handle_slot_pressed():
	popup = generic_popup.instantiate()
	for option in popup_options:
		popup.add_item(option)

	
	add_child(popup)
	popup.set_visible(true)
	popup.set_position(global_position)
	popup.set_focused_item(0)
	popup.grab_focus()

	popup.index_pressed.connect(_handle_popup_response)

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

