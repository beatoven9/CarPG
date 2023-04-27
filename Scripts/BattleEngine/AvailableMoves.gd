class_name AvailableMoves

var attack  # this is a Move
var attack_string
var magic  # this is a list of Move types
var magic_strings
var abilities # this is a list of Move types
var ability_strings
var items # this is a list of Move types
var items_strings
var flex_options = []# this is a list of Move types
var flex_name = ""

func initialize_values(
	attack_move,
	magic_moves,
	ability_moves,
	item_moves,
	flex_moves,
	new_flex_name
):
	attack = attack_move
	magic = magic_moves
	abilities = ability_moves
	items = item_moves
	flex_options = flex_moves
	flex_name = new_flex_name

func set_attack_move(new_move: base_move):
	attack = new_move
	attack_string = new_move.move_name

func set_magic_moves(new_move_list):
	magic = new_move_list
	var new_string_list = []
	for move in new_move_list:
		new_string_list.append(move.move_name)
	magic_strings = new_string_list

func set_ability_moves(new_move_list):
	abilities = new_move_list
	var new_string_list = []
	for move in new_move_list:
		new_string_list.append(move.move_name)
	ability_strings = new_string_list

func get_magic_strings():
	return magic_strings

func get_ability_strings():
	return ability_strings
