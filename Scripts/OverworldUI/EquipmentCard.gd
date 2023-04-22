extends MarginContainer

@onready var weapon_slot = $MarginContainer/HBoxContainer/EquipmentSlots/WeaponSlot
@onready var ring_slots = $MarginContainer/HBoxContainer/EquipmentSlots/RingSlots.get_children()

@onready var portrait_box: TextureRect = $MarginContainer/HBoxContainer/MarginContainer/VBoxContainer/CharacterPortrait
@onready var char_name_label: Label = $MarginContainer/HBoxContainer/MarginContainer/VBoxContainer/Label


func _ready():
	pass

