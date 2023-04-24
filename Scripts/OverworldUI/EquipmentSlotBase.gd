extends MarginContainer

signal request_new_equip(slot)
signal request_unequip(slot, item)

var current_item = "Sword of fire"

@onready var slot_button = $VBoxContainer/MarginContainer/Button
signal slot_pressed

var popup: PopupMenu

@onready var generic_popup = preload("res://Scenes/Overworld_UI/Popups/generic_popup.tscn")

func _ready():
	slot_button.pressed.connect(_handle_slot_pressed)

func _handle_slot_pressed():
	pass

func _on_slot_pressed():
	slot_pressed.emit(self)

func _handle_equip_request():
	request_new_equip.emit(self)

func handle_item_equip(item):
	# handle equipping this item to this slot
	print(item)

func _handle_unequip_request():
	request_unequip.emit(self, current_item)

func _handle_move_request():
	pass

func _handle_cancel_request():
	pass

