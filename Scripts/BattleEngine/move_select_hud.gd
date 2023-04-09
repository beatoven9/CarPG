extends MarginContainer


@onready var move_selection_entry = $MarginContainer/MoveSelectionEntryBox
@onready var move_selection_sub = $MarginContainer/MoveSelectionSubBox
@onready var target_selection_box = $MarginContainer/MoveSelectionTargetSelectBox
var move_list = []

func prompt_for_move(available_moves, battle_state):
	move_selection_entry.clear()
	move_selection_entry.item_activated.connect(_on_base_move_selected)
	for move in available_moves:
		move_selection_entry.add_item(move.move_name)
		move_list.append(move)
	

	set_visible(true)
	move_selection_entry.grab_focus()
	move_selection_entry.select(0)
	move_selection_entry.set_visible(true)
	
func _on_base_move_selected(move_index):
	print("Move selected: ", move_list[move_index].move_name )
	move = move_list[move_index]
	if move.sub_selection = false:
		prompt_for_target()


func prompt_for_target(move, battle_state):
	move_selection_entry.set_visible(false)
	var target_list = []
	# Add enemies to this list
	target_selection_box.set_visible(true)
