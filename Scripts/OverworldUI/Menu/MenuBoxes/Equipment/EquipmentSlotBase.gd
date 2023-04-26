extends MarginContainer

signal request_new_equip(slot, equip_type)
signal request_unequip(slot, item)

var current_item = "Sword of fire"

@onready var slot_button = $VBoxContainer/MarginContainer/Button
@onready var equip_container = $VBoxContainer/MarginContainer/EquipContainer
signal slot_pressed
var equip_type = EQUIP_TYPES.RING

var popup: PopupMenu

@onready var generic_popup = preload("res://Scenes/Overworld_UI/Popups/generic_popup.tscn")

func _ready():
	slot_button.pressed.connect(_handle_slot_pressed)

func _handle_slot_pressed():
	pass

func _on_slot_pressed():
	slot_pressed.emit(self)

func _handle_equip_request():
	request_new_equip.emit(self, equip_type)

func handle_item_equip(item):
	set_current_equip(item)

func _handle_unequip_request():
	if equip_container.get_child_count() > 0:
		var current_equip = get_current_equip()
		equip_container.remove_child(current_equip)
		request_unequip.emit(self, current_equip)

func _handle_move_request():
	pass

func _handle_cancel_request():
	pass

func set_current_equip(item):
	if equip_container.get_child_count() > 0:
		_handle_unequip_request()
	equip_container.add_child(item)

func get_current_equip():
	return equip_container.get_child(0)
