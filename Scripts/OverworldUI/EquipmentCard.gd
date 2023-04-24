extends MarginContainer

@onready var weapon_slot = $MarginContainer/HBoxContainer/EquipmentSlots/WeaponSlot
@onready var ring_slots = $MarginContainer/HBoxContainer/EquipmentSlots/RingSlots.get_children()

@onready var portrait_box: TextureRect = $MarginContainer/HBoxContainer/MarginContainer/VBoxContainer/CharacterPortrait
@onready var char_name_label: Label = $MarginContainer/HBoxContainer/MarginContainer/VBoxContainer/Label



func _ready():
	for slot in ring_slots:
		slot.button.pressed.connect(_handle_ring_slot_press)


func _handle_ring_slot_press():

	# This isn't really the way to handle this.
	# I should really have these modals created as scenes
	# Which modal is shown should be handled but the individual slot
	# not the EquipmentCard as done here.

	var popup: PopupMenu = PopupMenu.new()
	popup.set_max_size(Vector2(128, 128))
	popup.add_item("Item 1")
	popup.add_item("Item 2")
	add_child(popup)
	popup.set_visible(true)
	popup.grab_focus()
