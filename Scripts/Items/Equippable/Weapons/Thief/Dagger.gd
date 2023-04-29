extends BaseThiefWeapon
class_name Dagger

@onready var icon_texture: Texture2D = preload("res://Sprites/UI_Sprites/Items/Weapons/Dagger.png")

var base_attack = 10

func _init():
	set_name_string("Dagger")

func _ready():
	super._ready()
	set_icon_texture(icon_texture)
