extends MarginContainer

@onready var fighter_hud_container = get_node("FighterHUDContainer")
@onready var fighter_hud = preload("res://Scenes/Battle/fighter_hud.tscn")

func create_party(party_list):
	for fighter in party_list:
		var new_fighter_hud = fighter_hud.instantiate()
		print("FIGHTER NAME IS: ", fighter.fighter_name)
		new_fighter_hud.fighter_name = fighter.fighter_name

		fighter.health_changed.connect(new_fighter_hud.update_health_bar)
		fighter.boost_changed.connect(new_fighter_hud.update_boost_bar)
		fighter.timer_changed.connect(new_fighter_hud.update_timer_bar)

		fighter_hud_container.add_child(new_fighter_hud)

