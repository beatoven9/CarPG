class_name AvailableMoves

var attack  # this is a Move
var magic  # this is a list of Move types
var abilities # this is a list of Move types
var items # this is a list of Move types
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
