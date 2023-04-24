extends MarginContainer

@onready var party_members = $VBoxContainer/PartyMemberContainer.get_children()
@onready var first_slot = party_members[0].weapon_slot
@onready var last_focused_button = first_slot.slot_button

@onready var generic_popup = preload("res://Scenes/Overworld_UI/Popups/generic_popup.tscn")

@onready var equipment_slots

@onready var inventory_equipment_box = $InventoryEquipmentBox
var inventory_equipment

var current_slot

# We need to keep an array or a matrix of all of the equipment slots.
# This way when someone wants to move a ring or weapon, we can call
# the switch directly between two slots.
# When the box opens, all of the slots are set from the caller
# When the box closes, the current state of the slots are used to
# set the Party equipment data.

signal request_new_equip(equipment_slot)

var popup_options = [
	"Equip",
	"Unequip",
	"Move",
	"Change Mode",
	"Cancel"
]

func get_equipment_slots():
	var slots = []
	for member in party_members:
		var weapon_slot = member.weapon_slot
		slots.append(weapon_slot)
		var ring_slots = member.ring_slots
		slots += ring_slots

	return slots

func get_inventory_equipment():
	return [
		"ring of fire",
		"Ring of healing",
		"Lance",
		"Something else",
		"Ring of healing",
		"Twisted Staff",
		"Light Rod"
	]

func _ready():
	equipment_slots = get_equipment_slots()
	inventory_equipment = get_inventory_equipment()

	for slot in equipment_slots:
		slot.slot_pressed.connect(_handle_slot_press)

func _handle_slot_press(slot):
	current_slot = slot
	last_focused_button = slot.slot_button

	var popup = generic_popup.instantiate()
	popup.index_pressed.connect(_handle_popup_response)
	popup.popup_hide.connect(popup.queue_free)

	for option in popup_options:
		popup.add_item(option)

	add_child(popup)
	popup.set_visible(true)
	popup.set_position(slot.global_position)
	popup.set_focused_item(0)
	popup.grab_focus()

func handle_equip_request():
	inventory_equipment_box.set_visible(true)
	inventory_equipment_box.clear()
	for item in inventory_equipment:
		inventory_equipment_box.add_item(item)
	inventory_equipment_box.grab_focus()
	inventory_equipment_box.select(0)

	inventory_equipment_box.item_activated.connect(_handle_equip_response)
	

func _handle_equip_response(index):
	inventory_equipment_box.item_activated.disconnect(_handle_equip_response)
	var item = inventory_equipment[index]
	print(item, " assigned to slot ", current_slot)

	# assign_to_slot(item, current_slot)
	# remove_item_from_inventory(item)

	inventory_equipment_box.set_visible(false)
	activate_box()


func activate_box():
	last_focused_button.grab_focus()

func get_equipment_textures():
	for party_member in party_members:
		for slot in party_member.equipment_slots:
			pass


func _handle_popup_response(index):
	if popup_options[index] == "Equip":
		handle_equip_request()
	elif popup_options[index] == "Unequip":
		handle_unequip()
	elif popup_options[index] == "Move":
		handle_move()
	elif popup_options[index] == "Change Mode":
		handle_change_mode()
	elif popup_options[index] == "Cancel":
		handle_cancel()


func handle_equip():
	request_new_equip.emit(self)

func handle_unequip():
	pass

func handle_move():
	pass

func handle_change_mode():
	pass

func handle_cancel():
	pass
