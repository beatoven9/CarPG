extends Node


var rings = [
	FireRing.new(),
	AttackRing.new()
]


var black_mage_weapons = [
	BlackMageCaster.new(),
	BlackMageCaster.new(),
]

var dragoon_weapons = [
	Lance.new(),
	Lance.new(),
]

var gunner_weapons = [
	HandGun.new(),
	HandGun.new(),
]


var thief_weapons = [
	Dagger.new(),
	Dagger.new(),
]

var white_mage_weapons = [
	WhiteMageCaster.new(),
	WhiteMageCaster.new(),
]

var class_stones = [
	ThiefStone.new(),
	BlackMageStone.new(),
	GunnerStone.new(),
	WhiteMageStone.new(),
	DragoonStone.new(),
]

func get_class_stones():
	return class_stones

func get_weapons():
	var weapon_list = []
	weapon_list += black_mage_weapons
	weapon_list += dragoon_weapons
	weapon_list += gunner_weapons
	weapon_list += thief_weapons
	weapon_list += white_mage_weapons

	return weapon_list

func get_weapons_of_type(type_enum):
	if type_enum == FIGHTER_CLASSES.BLACK_MAGE:
		return black_mage_weapons
	elif type_enum == FIGHTER_CLASSES.DRAGOON:
		return dragoon_weapons
	elif type_enum == FIGHTER_CLASSES.GUNNER:
		return gunner_weapons
	elif type_enum == FIGHTER_CLASSES.THIEF:
		return thief_weapons
	elif type_enum == FIGHTER_CLASSES.WHITE_MAGE:
		return white_mage_weapons
	elif type_enum == FIGHTER_CLASSES.NONE:
		return get_weapons()

func get_rings():
	return rings

func get_equipment():
	var equipment_list = []
	equipment_list += get_weapons()
	equipment_list += get_rings()
	return equipment_list

func get_items():
	var item_list = []
	# append all types of items to this list.
	return item_list

func get_all_inventory():
	return []

func remove_inventory_item(item):
	if item.item_type == ITEM_TYPES.EQUIP:
		remove_equipment(item)
	elif item.item_type == ITEM_TYPES.ITEM:
		remove_item(item)

func remove_equipment(equipment):
	if equipment.equip_type == EQUIP_TYPES.CLASS_STONE:
		remove_class_stone(equipment)
	elif equipment.equip_type == EQUIP_TYPES.WEAPON:
		remove_weapon(equipment)
	elif equipment.equip_type == EQUIP_TYPES.RING:
		remove_ring(equipment)

func remove_class_stone(stone):
	class_stones.erase(stone)

func remove_weapon(weapon):
	if weapon.fighter_class == FIGHTER_CLASSES.BLACK_MAGE:
		remove_black_mage_weapon(weapon)
	elif weapon.fighter_class == FIGHTER_CLASSES.DRAGOON:
		remove_dragoon_weapon(weapon)
	elif weapon.fighter_class == FIGHTER_CLASSES.GUNNER:
		remove_gunner_weapon(weapon)
	elif weapon.fighter_class == FIGHTER_CLASSES.THIEF:
		remove_thief_weapon(weapon)
	elif weapon.fighter_class == FIGHTER_CLASSES.WHITE_MAGE:
		remove_white_mage_weapon(weapon)

func remove_black_mage_weapon(weapon):
	black_mage_weapons.erase(weapon)

func remove_dragoon_weapon(weapon):
	dragoon_weapons.erase(weapon)

func remove_gunner_weapon(weapon):
	gunner_weapons.erase(weapon)

func remove_thief_weapon(weapon):
	thief_weapons.erase(weapon)

func remove_white_mage_weapon(weapon):
	white_mage_weapons.erase(weapon)

func remove_ring(ring):
	rings.erase(ring)

func add_inventory_item(new_item):
	if new_item.item_type == ITEM_TYPES.EQUIP:
		add_equipment(new_item)
	elif new_item.item_type == ITEM_TYPES.ITEM:
		add_item(new_item)

func add_item(new_item):
	pass

func remove_item(item):
	pass

func add_equipment(new_equipment):
	if new_equipment.equip_type == EQUIP_TYPES.CLASS_STONE:
		add_class_stone(new_equipment)
	elif new_equipment.equip_type == EQUIP_TYPES.WEAPON:
		add_weapon(new_equipment)
	elif new_equipment.equip_type == EQUIP_TYPES.RING:
		add_ring(new_equipment)

func add_weapon(new_weapon):
	if new_weapon.fighter_class == FIGHTER_CLASSES.BLACK_MAGE:
		add_black_mage_weapon(new_weapon)
	elif new_weapon.fighter_class == FIGHTER_CLASSES.DRAGOON:
		add_dragoon_weapon(new_weapon)
	elif new_weapon.fighter_class == FIGHTER_CLASSES.GUNNER:
		add_gunner_weapon(new_weapon)
	elif new_weapon.fighter_class == FIGHTER_CLASSES.THIEF:
		add_thief_weapon(new_weapon)
	elif new_weapon.fighter_class == FIGHTER_CLASSES.WHITE_MAGE:
		add_white_mage_weapon(new_weapon)

func add_black_mage_weapon(new_weapon):
	black_mage_weapons.append(new_weapon)

func add_dragoon_weapon(new_weapon):
	dragoon_weapons.append(new_weapon)

func add_gunner_weapon(new_weapon):
	gunner_weapons.append(new_weapon)

func add_thief_weapon(new_weapon):
	thief_weapons.append(new_weapon)

func add_white_mage_weapon(new_weapon):
	white_mage_weapons.append(new_weapon)

func add_class_stone(new_stone):
	class_stones.append(new_stone)

func add_ring(new_ring):
	rings.append(new_ring)
