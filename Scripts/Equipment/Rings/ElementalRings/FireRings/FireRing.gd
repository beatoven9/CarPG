extends BaseFireRing
class_name FireRing

@onready var icon_texture: Texture2D = preload("res://Sprites/Weapons/FireRing.png")

var boost = 1.25

func _init():
	set_name_string("Fire Ring")

func _ready():
	super._ready()
	set_icon_texture(icon_texture)
