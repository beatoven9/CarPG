extends BaseFireRing
class_name FireRing

@onready var icon_texture: Texture2D = preload("res://Sprites/Weapons/FireRing.png")

var boost = 1.25
var local_description = "Grants 10bp of fire damage for melee attacks and 1.25% damage increase to fire spells"
var local_effect = "Fire Boost"

func _init():
	set_name_string("Fire Ring")
	set_description(local_description)
	set_effect(local_effect)

func _ready():
	super._ready()
	set_icon_texture(icon_texture)
