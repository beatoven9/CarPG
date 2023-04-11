extends "res://Scripts/BattleEngine/Fighter.gd"

@onready var player_hud_container = get_tree().get_root().get_child(0).get_node("CanvasLayer/PlayerPartyHUD/FighterHUDContainer")
@onready var fighter_hud_resource = preload("res://Scenes/Battle/UI/fighter_hud.tscn")

@onready var move_select_box_parent = get_tree().get_root().get_child(0).get_node("CanvasLayer/MoveSelectionControl")
# @onready var move_selection_box = preload("res://Scenes/Battle/UI/move_selection_dialogue_root.tscn")
@onready var move_selection_box = preload("res://Scenes/Battle/UI/MoveSelection/move_selection_dialogue_root.tscn")

var dialogue_box

func _ready():
	super._ready()

	dialogue_box = move_selection_box.instantiate()
	move_select_box_parent.add_child(dialogue_box)

	dialogue_box.move_complete.connect(_on_move_ready)

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
	var available_moves = get_available_moves()

	dialogue_box.prompt_for_move(
		self,
		available_moves,
		battle_state
	)
