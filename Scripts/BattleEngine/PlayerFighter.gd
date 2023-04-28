extends "res://Scripts/BattleEngine/Fighter.gd"

@onready var battle_ui = get_tree().get_root().get_node("BattleScene").get_node("CanvasLayer/BattleUI")
@onready var player_hud_container = battle_ui.player_party_hud_container
@onready var fighter_hud_resource = preload("res://Scenes/Battle/UI/fighter_hud.tscn")
@onready var dialogue_box = battle_ui.move_selection_dialogue

func _ready():
	print(battle_ui.move_announcer_box)
	super._ready()

	var new_fighter_hud = fighter_hud_resource.instantiate()
	new_fighter_hud.fighter_name = fighter_name
	health_changed.connect(new_fighter_hud.update_health_bar)
	boost_changed.connect(new_fighter_hud.update_boost_bar)
	timer_changed.connect(new_fighter_hud.update_timer_bar)
	player_hud_container.add_child(new_fighter_hud)

	fighter_hud = new_fighter_hud

func get_available_moves():
	var available_moves = fighter_class.get_available_moves(class_proficiency)
	return available_moves


func request_move(battle_state):
	print("Requesting move from: ", fighter_name)
	if len(move_queue) == 0:
		dialogue_box.move_complete.connect(_on_move_ready)
		var available_moves = get_available_moves()

		dialogue_box.prompt_for_move(
			self,
			available_moves,
			battle_state
		)
	elif len(move_queue) > 0:
		var move_info = pop_move_from_queue()
		move_ready.emit(move_info)

func _on_move_ready(move, target):
	dialogue_box.move_complete.disconnect(_on_move_ready)
	super._on_move_ready(move, target)

func update_hud():
	fighter_hud.update_health_bar(current_health, max_health)
	fighter_hud.update_boost_bar(current_boost, max_boost)
	
func _process(_delta):
	update_timer_bar()

func _on_second_tick():
	super._on_second_tick()
	update_hud()

func update_timer_bar():
	var time_left = battle_timer.time_left
	var max_time = get_battle_timer_length()
	var timer_bar_val = 100 - ((time_left / max_time) * 100)
	timer_changed.emit(timer_bar_val)

