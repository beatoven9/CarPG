extends "res://Scripts/BattleEngine/Fighter.gd"

@onready var enemy_hud_container = get_tree().get_root().get_child(0).get_node("CanvasLayer/EnemyPartyHUD/MarginContainer/FighterHUDContainer")
@onready var fighter_hud_resource = preload("res://Scenes/Battle/UI/fighter_hud.tscn")

func _ready():
	super._ready()

	var new_fighter_hud = fighter_hud_resource.instantiate()
	new_fighter_hud.fighter_name = fighter_name
	health_changed.connect(new_fighter_hud.update_health_bar)
	boost_changed.connect(new_fighter_hud.update_boost_bar)
	timer_changed.connect(new_fighter_hud.update_timer_bar)
	enemy_hud_container.add_child(new_fighter_hud)

	fighter_hud = new_fighter_hud

func _on_death():
	super._on_death()
