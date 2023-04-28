extends "res://Scripts/OverworldUI/Menu/MenuBoxes/Equipment/EquipmentSlotBase.gd"
class_name WeaponSlot


var popup_options = [
	"Equip",
	"Unequip",
	"Cancel"
]

func _init():
	equip_type = EQUIP_TYPES.WEAPON

func _ready():
	super._ready()

func get_current_class():
	if len(equip_container.get_children()) > 0:
		var weapon: BaseWeapon = equip_container.get_child(0)
		return weapon.fighter_class
	else:
		return FIGHTER_CLASSES.NONE
