extends MarginContainer

signal go_back
signal equip_item(item)

@onready var party_members = $VBoxContainer/MarginContainer/PartyMemberContainer.get_children()
@onready var first_slot = party_members[0].class_slot
@onready var last_focused_button = first_slot.slot_button

@onready var generic_popup = preload("res://Scenes/Overworld_UI/Popups/generic_popup.tscn")

@onready var equipment_slots

@onready var inventory_equipment_box = $VBoxContainer/MarginContainer/InventoryEquipmentBox
@onready var equip_info_box = $VBoxContainer/EquipInfoContainer
# var inventory_equipment

var current_slot

# We need to keep an array or a matrix of all of the equipment slots.
# This way when someone wants to move a ring or weapon, we can call
# the switch directly between two slots.
# When the box opens, all of the slots are set from the caller
# When the box closes, the current state of the slots are used to
# set the Party equipment data.

signal request_new_equip(equipment_slot)

func _input(event):
	if equipment_box_focused():
		if event.is_action_pressed("ui_cancel"):
			go_back.emit()
			accept_event()

func close_equipment_box():
	inventory_equipment_box.item_activated.disconnect(_handle_equip_response)
	equip_item.disconnect(current_slot.handle_item_equip)


func get_equipment_slots():
	var slots = []
	for member in party_members:
		var class_slot = member.class_slot
		var weapon_slot = member.weapon_slot
		slots.append(class_slot)
		slots.append(weapon_slot)
		var ring_slots = member.ring_slots
		slots += ring_slots

	return slots

var inventory_list = [
	StandardSword.new(),
	StandardSword.new(),
	StandardDagger.new(),
	StandardHammer.new(),
	FireRing.new(),
	FireRing.new(),
	AttackRing.new(),
	AttackRing.new(),
	AttackRing.new(),
	AttackRing.new(),
]

func get_inventory_equipment():
	return inventory_list

func populate_box(_equipment_data_list):
	pass

func _ready():
	equipment_slots = get_equipment_slots()
	# inventory_equipment = get_inventory_equipment()
	inventory_equipment_box.cancel_inventory_box.connect(_handle_box_exited)
	inventory_equipment_box.item_selected.connect(
		func (idx): 
			var selected_item = get_inventory_equipment()[idx]
			equip_info_box.set_item_info(selected_item)
	)


	for slot in equipment_slots:
		slot.request_new_equip.connect(handle_equip_request)
		slot.request_unequip.connect(handle_unequip_request)
		slot.on_focus_entered.connect(handle_slot_focused)


func handle_slot_focused(slot):
	if slot.has_equip():
		var equipped_item = slot.get_current_equip()
		equip_info_box.set_item_info(equipped_item)
	else:
		equip_info_box.clear_info()

func _handle_box_exited():
	close_equipment_box()
	inventory_equipment_box.set_visible(false)
	last_focused_button.grab_focus()

func handle_equip_request(slot, _equip_type):
	current_slot = slot
	last_focused_button = slot.slot_button
	inventory_equipment_box.set_visible(true)
	inventory_equipment_box.clear()
	for i in range(len(inventory_list)):
		var item = inventory_list[i]
		inventory_equipment_box.add_item(item.name_string)

		#if item.equip_type != equip_type:
		#	inventory_equipment_box.set_item_selectable(i, false)

	inventory_equipment_box.grab_focus()
	inventory_equipment_box.select(0)

	inventory_equipment_box.item_activated.connect(_handle_equip_response)
	equip_item.connect(slot.handle_item_equip)


func handle_unequip_request(_slot, item):
	inventory_list.append(item)
	

func disconnect_slots():
	pass

func _handle_equip_response(index):
	var item = inventory_list[index]
	if current_slot.equip_type == item.equip_type:
		inventory_equipment_box.item_activated.disconnect(_handle_equip_response)

		equip_item.emit(item)
		
		inventory_list.erase(item)

		equip_item.disconnect(current_slot.handle_item_equip)

		deactivate_inventory_equipment_box()
		last_focused_button.grab_focus.call_deferred()


func activate_box():
	last_focused_button.grab_focus()
	deactivate_inventory_equipment_box()

func select_box():
	deactivate_inventory_equipment_box()

func deactivate_inventory_equipment_box():
	inventory_equipment_box.set_visible(false)


func get_equipment_textures():
	for party_member in party_members:
		for slot in party_member.equipment_slots:
			pass

func equipment_box_focused():
	for slot in equipment_slots:
		if slot.slot_button.has_focus():
			return true
	return false