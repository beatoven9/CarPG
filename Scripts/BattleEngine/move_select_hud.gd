extends MarginContainer

signal move_complete(move, target)

@onready var move_selection_entry = $MarginContainer/MoveSelectionEntryBox
@onready var move_selection_sub = $MarginContainer/MoveSelectionSubBox
@onready var target_selection_box = $MarginContainer/MoveSelectionTargetSelectBox
var move_list = []
var current_battle_state
var selected_move

# This isn't really how this should be implemented.
# All moves need to just be moves. rn the set up is that "magic" will
# be a move and all spells will just be in the sub_selection menu
# This won't work
# I should have selections in the main menu.
# Maybe okokok this is it.
# The dialogue box will have different layers from the get go.
# Each move will have a property called 'move_selection_level'
# This will inform the selection box of where in the menu to put the item.
# wait. Maybe the 


# OKOKOKOK The best way to do this is to give everyone their
# own dialogue box. This way, we can just keep all the signals
# connected without any worry at all.
# We can keep them in a node so that we can create a list of children easily
# We'll then index into it the same way we index into the
# player party list

func _ready():
	move_selection_entry.item_activated.connect(_on_base_move_selected)
	target_selection_box.item_activated.connect(_on_target_selected)

func prompt_for_move(available_moves, new_battle_state):
	print("Hello from dialogue box")
	current_battle_state = new_battle_state
	move_selection_entry.clear()
	move_list = []
	for move in available_moves:
		move_selection_entry.add_item(move.move_name)
		move_list.append(move)
	

	set_visible(true)
	move_selection_entry.grab_focus()
	move_selection_entry.select(0)
	move_selection_entry.set_visible(true)
	
func _on_base_move_selected(move_index):
	var move = move_list[move_index]
	selected_move = move
	if len(move.sub_selection) == 0:
		prompt_for_target(move, current_battle_state)
	elif len(move.sub_selection) > 0:
		prompt_subdir(move.sub_selection)


func prompt_subdir(sub_dir_selection):
	move_selection_entry.set_visible(false)
	move_selection_entry.clear()

	for item in sub_dir_selection:
		move_selection_sub.add_item(item)

	move_selection_sub.set_visible(true)


func prompt_for_target(move, battle_state):
	move_selection_entry.set_visible(false)
	target_selection_box.clear()

	var target_list = []
	for enemy in battle_state["enemy_fighters"]:
		target_list.append(enemy)
		target_selection_box.add_item(enemy.fighter_name)

	target_selection_box.grab_focus()
	target_selection_box.select(0)
	target_selection_box.set_visible(true)

func _on_target_selected(target_index):
	var target = current_battle_state["enemy_fighters"][target_index]
	move_complete.emit(selected_move, target)
	target_selection_box.set_visible(false)
	set_visible(false)

func _on_subdir_selection(selection_idx):
	selected_move.sub_selection[selection_idx]	
