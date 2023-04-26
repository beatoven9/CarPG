extends BaseAttackRing
class_name AttackRing

var boost = 1.25

func _init():
	set_name_string("Attack Ring")

func _ready():
	super._ready()
	set_icon_texture(icon_texture)

