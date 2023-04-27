extends MarginContainer

@onready var class_slot: ClassSlot = $MarginContainer/HBoxContainer/EquipmentSlots/ClassSlot
@onready var weapon_slot: WeaponSlot = $MarginContainer/HBoxContainer/EquipmentSlots/WeaponSlot
@onready var ring_slots: Array = $MarginContainer/HBoxContainer/EquipmentSlots/RingSlots.get_children()

@onready var portrait_box: TextureRect = $MarginContainer/HBoxContainer/MarginContainer/VBoxContainer/CharacterPortrait
@onready var name_label: Label = $MarginContainer/HBoxContainer/MarginContainer/VBoxContainer/Label



func _ready():
	pass
	#for slot in ring_slots:
	#	slot.slot_button.pressed.connect(_handle_ring_slot_press)


func _handle_ring_slot_press():
	pass

func set_card_info(party_member: PartyMember):
	set_card_name(party_member.name_string)
	set_portrait(party_member.get_portrait())
	set_class_stone(party_member.get_class_stone())
	set_weapon(party_member.get_weapon())
	set_ring_1(party_member.get_ring_1())
	set_ring_2(party_member.get_ring_2())
	set_ring_3(party_member.get_ring_3())

func set_card_name(text: String):
	name_label.set_text(text)

func set_portrait(new_texture: Texture2D):
	portrait_box.set_texture(new_texture)
	portrait_box.set_anchors_preset(TextureRect.PRESET_FULL_RECT)
	portrait_box.set_stretch_mode(TextureRect.STRETCH_KEEP_ASPECT)

func set_class_stone(new_stone: BaseClassStone):
	class_slot.set_current_equip(new_stone)

func set_weapon(new_weapon: BaseWeapon):
	weapon_slot.set_current_equip(new_weapon)

func set_ring_1(new_ring: BaseRing):
	ring_slots[0].set_current_equip(new_ring)

func set_ring_2(new_ring: BaseRing):
	ring_slots[1].set_current_equip(new_ring)

func set_ring_3(new_ring: BaseRing):
	ring_slots[2].set_current_equip(new_ring)

func set_ring_1_mode(new_mode):
	pass

func set_ring_2_mode(new_mode):
	pass

func set_ring_3_mode(new_mode):
	pass
