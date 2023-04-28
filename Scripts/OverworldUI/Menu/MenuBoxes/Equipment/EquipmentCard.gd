extends MarginContainer

@onready var class_slot: ClassSlot = $MarginContainer/HBoxContainer/EquipmentSlots/ClassSlot
@onready var weapon_slot: WeaponSlot = $MarginContainer/HBoxContainer/EquipmentSlots/WeaponSlot
@onready var ring_slots: Array = $MarginContainer/HBoxContainer/EquipmentSlots/RingSlots.get_children()

@onready var portrait_box: TextureRect = $MarginContainer/HBoxContainer/MarginContainer/VBoxContainer/CharacterPortrait
@onready var name_label: Label = $MarginContainer/HBoxContainer/MarginContainer/VBoxContainer/Label

var popup: GenericPopup
var change_mode_popup: GenericPopup
var inventory_select_popup: SelectEquipPopup

@onready var generic_popup = preload("res://Scenes/Overworld_UI/Popups/generic_popup.tscn")
@onready var select_equip_popup = preload("res://Scenes/Overworld_UI/Popups/select_equip_popup.tscn")

signal on_class_stone_activated
signal on_weapon_activated
signal on_ring_1_activated
signal on_ring_2_activated
signal on_ring_3_activated

signal request_new_equip(equip_request_dict) #{"slot":, "current_class":}
signal item_selected(item)

var current_slot: BaseEquipmentSlot

func _ready():
	class_slot.slot_pressed.connect(_on_slot_pressed)

	weapon_slot.slot_pressed.connect(_on_slot_pressed)
	ring_slots[0].slot_pressed.connect(_on_slot_pressed)
	ring_slots[1].slot_pressed.connect(_on_slot_pressed)
	ring_slots[2].slot_pressed.connect(_on_slot_pressed)

	class_slot.on_focus_entered.connect(_handle_item_focused)
	weapon_slot.on_focus_entered.connect(_handle_item_focused)
	ring_slots[0].on_focus_entered.connect(_handle_item_focused)
	ring_slots[1].on_focus_entered.connect(_handle_item_focused)
	ring_slots[2].on_focus_entered.connect(_handle_item_focused)

func _on_slot_pressed(slot):
	current_slot = slot
	create_popup_prompt(slot)

func create_popup_prompt(slot: BaseEquipmentSlot):
	popup = generic_popup.instantiate()
	popup.set_items(slot.popup_options)

	slot.add_child(popup)
	popup.set_visible(true)
	popup.set_position(slot.global_position)
	popup.set_focused_item(0)
	popup.grab_focus()

	popup.response.connect(_handle_popup_response)

func _handle_popup_response(response_string):
	var callback = {
		"Equip": create_item_select_popup,
		"Unequip": _handle_unequip_request,
		"Change Mode": _handle_change_mode_request,
		"Cancel": _handle_cancel_request
	}[response_string]

	callback.call()

func create_item_select_popup():
	var selectable_inventory = get_selectable_inventory(current_slot)
	inventory_select_popup = select_equip_popup.instantiate()
	current_slot.add_child(inventory_select_popup)
	inventory_select_popup.response.connect(_handle_item_select_response)
	inventory_select_popup.item_selected.connect(_handle_item_focused)

	inventory_select_popup.set_items(selectable_inventory)
	
	inventory_select_popup.set_visible(true)
	inventory_select_popup.set_position(current_slot.global_position)
	inventory_select_popup.set_focused_item(0)
	inventory_select_popup.grab_focus()


func _handle_item_focused(item):
	item_selected.emit(item)

func _handle_item_select_response(item):
	equip_item(item)

func equip_item(item: BaseEquipment):
	var unequipped_item = current_slot.set_current_equip(item)
	GlobalInventory.remove_inventory_item(item)
	if item.equip_type == EQUIP_TYPES.CLASS_STONE:
		if item.fighter_class != weapon_slot.get_current_class():
			var class_incompatible_item = weapon_slot.unequip_item()
			if is_instance_valid(class_incompatible_item):
				return_to_inventory(class_incompatible_item)
	elif item.equip_type == EQUIP_TYPES.WEAPON:
		if item.fighter_class != class_slot.get_current_class():
			var class_incompatible_item = class_slot.unequip_item()
			if is_instance_valid(class_incompatible_item):
				return_to_inventory(class_incompatible_item)

	if is_instance_valid(unequipped_item):
		return_to_inventory(unequipped_item)
	else:
		pass
	
func _handle_unequip_request():
	var unequipped_item = current_slot.unequip_item()
	if is_instance_valid(unequipped_item):
		return_to_inventory(unequipped_item)
	else:
		pass

func _handle_change_mode_request():
	change_mode_popup = generic_popup.instantiate()
	change_mode_popup.set_items(["offense", "defense", "tactical"])
	current_slot.add_child(change_mode_popup)

	change_mode_popup.set_visible(true)
	change_mode_popup.set_position(current_slot.global_position)
	change_mode_popup.set_focused_item(0)
	change_mode_popup.grab_focus()
	change_mode_popup.response.connect(_handle_change_mode_response)

func _handle_change_mode_response(response_string):
	var ring_mode = {
		"offense": RING_MODES.OFFENSE,
		"defense": RING_MODES.DEFENSE,
		"tactical": RING_MODES.TACTICAL,
	}[response_string]

	current_slot.set_mode(ring_mode)

func return_to_inventory(item):
	print("Adding item to inventory")
	GlobalInventory.add_inventory_item(item)

func get_selectable_inventory(slot):
	var selectable_inventory
	var current_class = get_current_class()

	if slot.equip_type == EQUIP_TYPES.CLASS_STONE:
		selectable_inventory = GlobalInventory.get_class_stones()
	elif slot.equip_type == EQUIP_TYPES.WEAPON:
		selectable_inventory = GlobalInventory.get_weapons_of_type(current_class)
	elif slot.equip_type == EQUIP_TYPES.RING:
		selectable_inventory = GlobalInventory.get_rings()

	return selectable_inventory

func _handle_cancel_request():
	pass

func set_card_info(party_member: PartyMember):
	var new_name = party_member.get_name_string()
	var new_portrait = party_member.get_portrait()
	var new_class_stone = party_member.get_class_stone()
	var new_weapon = party_member.get_weapon()
	var new_ring_1 = party_member.get_ring_1()
	var new_ring_2 = party_member.get_ring_2()
	var new_ring_3 = party_member.get_ring_3()

	set_card_name(new_name)
	set_portrait(new_portrait)
	set_class_stone(new_class_stone)
	set_weapon(new_weapon)
	set_ring_1(new_ring_1)
	set_ring_2(new_ring_2)
	set_ring_3(new_ring_3)

func set_card_name(text: String):
	name_label.set_text(text)

func set_portrait(new_texture: Texture2D):
	portrait_box.set_texture(new_texture)
	portrait_box.set_anchors_preset(TextureRect.PRESET_FULL_RECT)
	portrait_box.set_stretch_mode(TextureRect.STRETCH_KEEP_ASPECT)

func set_class_stone(new_stone: BaseClassStone):
	if is_instance_valid(new_stone):
		class_slot.set_current_equip(new_stone)

func set_weapon(new_weapon: BaseWeapon):
	if is_instance_valid(new_weapon):
		weapon_slot.set_current_equip(new_weapon)

func set_ring_1(new_ring: BaseRing):
	if is_instance_valid(new_ring):
		ring_slots[0].set_current_equip(new_ring)

func set_ring_2(new_ring: BaseRing):
	if is_instance_valid(new_ring):
		ring_slots[1].set_current_equip(new_ring)

func set_ring_3(new_ring: BaseRing):
	if is_instance_valid(new_ring):
		ring_slots[2].set_current_equip(new_ring)

func get_current_class():
	return class_slot.get_current_class()	 
