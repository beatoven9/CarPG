extends BaseAttackRing
class_name AttackRing

var boost = 1.25
var local_description = "This ring boosts your base attack by 10. The higher the level, the more potent the effects."
var local_effect = "Attack Boost"

func _init():
	set_name_string("Attack Ring")
	set_description(local_description)
	set_effect(local_effect)

func _ready():
	super._ready()
	set_icon_texture(icon_texture)

