extends "res://Scripts/BattleEngine/Fighter.gd"

func request_move(battle_state, move_select_box):
	var enemy_fighters = battle_state["enemy_fighters"]

	var available_moves = fighter_class.get_available_moves(class_proficiency)
	print("Available moves: ")
	for move in available_moves:
		print(move.move_name)
	
	move_select_box.prompt_for_move(
		available_moves,
		battle_state
	)



