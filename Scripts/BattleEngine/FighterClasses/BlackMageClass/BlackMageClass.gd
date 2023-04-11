class_name BlackMageClass


static func get_available_moves(class_proficiency):
	var available_moves = AvailableMoves.new()

	var attack = SPIRIT.new()

	var magic = []

	if class_proficiency > 20:
		magic.append(FIRE.new())

	if class_proficiency > 40:
		magic.append(BLIZZARD.new())

	available_moves.initialize_values(
		attack,
		magic,
		[],
		[],
		[],
		""
	)

	return available_moves
