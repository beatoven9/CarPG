extends MarginContainer


@onready var move_selection_entry = $MarginContainer/MoveSelectionEntryBox
var move_list = []

func prompt_for_move(available_moves, battle_state):
	move_selection_entry.clear()
	move_selection_entry.item_activated.connect(_on_item_selected)
	for move in available_moves:
		move_selection_entry.add_item(move.move_name)
		move_list.append(move)
	

	set_visible(true)
	move_selection_entry.grab_focus()
	move_selection_entry.select(0)
	move_selection_entry.set_visible(true)
	
func _on_item_selected(move_index):
	print("Move selected: ", move_list[move_index].move_name )
