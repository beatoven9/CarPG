extends BaseBlackMageWeapon
class_name BlackMageCaster

@onready var icon_texture: Texture2D = preload("res://Sprites/UI_Sprites/Items/Weapons/BlackMageCaster.png")
var local_description = "This weapon deals magic damage. Only usable when playing as a Black Mage."
var local_effect = "Casts Black Magic Spells"

var base_attack = 10

func _init():
	set_name_string("Dark Caster")
	set_description(local_description)
	set_effect(local_effect)

func _ready():
	super._ready()
	set_icon_texture(icon_texture)

