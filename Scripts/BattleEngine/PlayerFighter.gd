extends "res://Scripts/BattleEngine/Fighter.gd"

@onready var move_selection_box = preload("res://Scenes/Battle/UI/move_selection_dialogue.tscn")
@onready var move_select_box_parent = get_tree().get_root().get_child(0).get_node("CanvasLayer/MoveSelectionBoxes")

var dialogue_box

func _ready():
	super._ready()
	dialogue_box = move_selection_box.instantiate()
	move_select_box_parent.add_child(dialogue_box)

	dialogue_box.move_complete.connect(_on_move_ready)

func request_move(battle_state):
	var enemy_fighters = battle_state["enemy_fighters"]

	var available_moves = fighter_class.get_available_moves(class_proficiency)

	dialogue_box.prompt_for_move(
		available_moves,
		battle_state
	)
