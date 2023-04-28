extends MarginContainer

signal go_back
signal equip_item(item)

@onready var card_container = $VBoxContainer/MarginContainer/PartyMemberContainer
var first_button
var last_focused_button
var equipment_card = preload("res://Scenes/Overworld_UI/EquipmentBox/equipment_card.tscn")

@onready var generic_popup = preload("res://Scenes/Overworld_UI/Popups/generic_popup.tscn")

var equipment_slots

@onready var inventory_equipment_box = $VBoxContainer/MarginContainer/InventoryEquipmentBox
@onready var equip_info_box = $VBoxContainer/EquipInfoContainer

var current_slot

signal request_new_equip(equipment_slot)

func _input(event):
	if equipment_box_focused():
		if event.is_action_pressed("ui_cancel"):
			go_back.emit()
			accept_event()

func populate_equipment_cards(party_members):
	for child in card_container.get_children():
		child.queue_free()

	for party_member in party_members:
		pass

func get_equipment_slots():
	var slots = []
	for member in card_container.get_children():
		var class_slot = member.class_slot
		var weapon_slot = member.weapon_slot
		slots.append(class_slot)
		slots.append(weapon_slot)
		var ring_slots = member.ring_slots
		slots += ring_slots

	return slots

func populate_box(data_dict):
	var party_members = data_dict["party_members"]
	for child in card_container.get_children():
		child.queue_free()

	for party_member in party_members:
		var new_card = equipment_card.instantiate()
		card_container.add_child(new_card)
		new_card.set_card_info(party_member)
		new_card.item_selected.connect(set_item_info)


func get_party():
	var party_member_1 = GovGearson.new()
	var party_member_2: Wedge = Wedge.new()
	var party_member_3 = Tristan.new()
	party_member_1.set_status("poison", true)
	party_member_1.set_status("mute", true)
	party_member_1.set_status("blind", true)
	party_member_2.set_status("mute", true)
	party_member_3.set_status("mute", true)
	party_member_3.set_status("poison", true)
	return [party_member_1, party_member_2, party_member_3]

func _ready():
	var party = get_party()
	var data_dict = {"party_members": party, "inventory": []}
	populate_box(data_dict)
	# Populate partMemberCard list here and attach to container
	first_button = card_container.get_children()[0].class_slot.slot_button
	last_focused_button = first_button
	equipment_slots = get_equipment_slots()
	inventory_equipment_box.cancel_inventory_box.connect(_handle_box_exited)

func set_item_info(item):
	equip_info_box.set_item_info(item)


func handle_slot_focused(slot):
	if slot.has_equip():
		var equipped_item = slot.get_current_equip()
		equip_info_box.set_item_info(equipped_item)
	else:
		equip_info_box.clear_info()

func _handle_box_exited():
	inventory_equipment_box.set_visible(false)
	last_focused_button.grab_focus()


func activate_box():
	last_focused_button.grab_focus()
	deactivate_inventory_equipment_box()

func select_box():
	deactivate_inventory_equipment_box()

func deactivate_inventory_equipment_box():
	inventory_equipment_box.set_visible(false)


func equipment_box_focused():
	for slot in get_equipment_slots():
		if slot.slot_button.has_focus():
			return true
	return false
