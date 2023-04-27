extends BaseWhiteMageWeapon
class_name WhiteMageCaster

@onready var icon_texture: Texture2D = preload("res://Sprites/UI_Sprites/Items/Weapons/WhiteMageCaster.png")
var local_description = "This weapon deals magic damage and healing. Only usable when playing as a White Mage."
var local_effect = "Casts White Magic Spells"

var base_attack = 10

func _init():
	set_name_string("Light Caster")
	set_description(local_description)
	set_effect(local_effect)

func _ready():
	super._ready()
	set_icon_texture(icon_texture)

