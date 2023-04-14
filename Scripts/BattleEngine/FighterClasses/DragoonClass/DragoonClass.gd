class_name DragoonClass


static func get_available_moves(class_proficiency):
	var available_moves = AvailableMoves.new()

	var attack = JUMP.new()

	var abilities = []

	if class_proficiency > 20:
		abilities.append(JUMP_HIGH.new())

	if class_proficiency > 40:
		abilities.append(SWIPE.new())

	available_moves.initialize_values(
		attack,
		[],
		abilities,
		[],
		[],
		""
	)

	return available_moves

