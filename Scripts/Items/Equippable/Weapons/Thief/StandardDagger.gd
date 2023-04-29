extends BaseThiefWeapon
class_name StandardDagger

@onready var icon_texture: Texture2D = preload("res://Sprites/Weapons/standard-sword.png")
var local_description = "This weapon deals melee damage. Only usable when playing as a thief."
var local_effect = "Deal Melee Damage"

var base_attack = 10

func _init():
	set_name_string("Standard Dagger")
	set_description(local_description)
	set_effect(local_effect)

func _ready():
	super._ready()
	set_icon_texture(icon_texture)

