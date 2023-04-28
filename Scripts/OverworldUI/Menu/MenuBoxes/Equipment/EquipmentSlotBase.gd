extends MarginContainer
class_name BaseEquipmentSlot

signal request_new_equip(slot, equip_type)
signal request_unequip(slot, item)
signal on_focus_entered(slot)
signal slot_pressed

var current_item = "Sword of fire"

@onready var slot_button = $VBoxContainer/MarginContainer/Button
@onready var equip_container = $VBoxContainer/MarginContainer/EquipContainer
var equip_type = EQUIP_TYPES.RING

var popup: PopupMenu

@onready var generic_popup = preload("res://Scenes/Overworld_UI/Popups/generic_popup.tscn")

func _ready():
	slot_button.pressed.connect(_handle_slot_pressed)
	slot_button.focus_entered.connect(_handle_focus_entered)

func _handle_slot_pressed():
	slot_pressed.emit(self)

func _handle_focus_entered():
	on_focus_entered.emit(self)

func _handle_equip_request():
	request_new_equip.emit(self, equip_type)

func unequip_item():
	if equip_container.get_child_count() > 0:
		var current_equip = get_current_equip()
		equip_container.remove_child(current_equip)
		return current_equip
	else:
		return null

func set_current_equip(item):
	if equip_container.get_child_count() > 0:
		var unequipped_item = unequip_item()
		equip_container.add_child(item)
		return unequipped_item
	else:
		equip_container.add_child(item)
		return null

func get_current_equip():
	return equip_container.get_child(0)

func has_equip():
	if len(equip_container.get_children()) > 0:
		return true
	else:
		return false
