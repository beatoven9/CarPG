extends BaseGunnerWeapon
class_name HandGun

@onready var icon_texture: Texture2D = preload("res://Sprites/UI_Sprites/Items/Weapons/HandGun.png")

var base_attack = 10

func _init():
	set_name_string("HandGun")

func _ready():
	super._ready()
	set_icon_texture(icon_texture)

