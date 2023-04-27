extends BaseClassStone
class_name BlackMageStone


var fighter_class = FIGHTER_CLASSES.BLACK_MAGE


static func get_available_moves(class_proficiency):
	var available_moves = AvailableMoves.new()

	var attack = SPIRIT.new()

	var magic = []
	var abilities = []

	if class_proficiency > 20:
		magic.append(FIRE.new())

	if class_proficiency > 40:
		magic.append(BLIZZARD.new())

	available_moves.set_attack_move(attack)
	available_moves.set_magic_moves(magic)
	available_moves.set_ability_moves(abilities)

	return available_moves
