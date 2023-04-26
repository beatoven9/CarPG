extends BaseThiefWeapon
class_name StandardDagger

@onready var icon_texture: Texture2D = preload("res://Sprites/Weapons/standard-sword.png")

var base_attack = 10

func _init():
	set_name_string("Standard Dagger")

func _ready():
	super._ready()
	set_icon_texture(icon_texture)

