extends "res://Scripts/OverworldUI/Menu/MenuBoxes/Equipment/EquipmentSlotBase.gd"
class_name RingSlot

@onready var mode_label: Label = $VBoxContainer/Label

var popup_options = [
	"Equip",
	"Unequip",
	"Change Mode",
	"Cancel"
]

var current_mode = RING_MODES.OFFENSE

func _init():
	equip_type = EQUIP_TYPES.RING

func _ready():
	super._ready()
	refresh_mode_string()

func _handle_equip_request():
	super._handle_equip_request()

func set_mode(mode):
	current_mode = mode
	refresh_mode_string()

func refresh_mode_string():
	if current_mode == RING_MODES.OFFENSE:
		mode_label.set_text("Offense")
	elif current_mode == RING_MODES.DEFENSE:
		mode_label.set_text("Defense")
	elif current_mode == RING_MODES.TACTICAL:
		mode_label.set_text("Tactical")
