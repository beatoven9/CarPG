extends "res://Scripts/BattleEngine/Fighter.gd"

@onready var player_hud_container = get_tree().get_root().get_child(0).get_node("CanvasLayer/BattleUI/HBoxContainer/PlayerPartyHUD/MarginContainer/FighterHUDContainer")
@onready var fighter_hud_resource = preload("res://Scenes/Battle/UI/fighter_hud.tscn")
@onready var dialogue_box = get_tree().get_root().get_child(0).get_node("CanvasLayer/BattleUI/HBoxContainer/MoveSelectionDialogue")

#@onready var move_select_box_parent = get_tree().get_root().get_child(0).get_node("CanvasLayer/BattleUI/HBoxContainer/MoveSelectionControl")
# @onready var move_selection_box = preload("res://Scenes/Battle/UI/move_selection_dialogue_root.tscn")
@onready var move_selection_box = preload("res://Scenes/Battle/UI/MoveSelection/move_selection_dialogue_root.tscn")

#var dialogue_box

func _ready():
	super._ready()

	# dialogue_box = move_selection_box.instantiate()
	# move_select_box_parent.add_child(dialogue_box)


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

