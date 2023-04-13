class_name MonkClass


static func get_available_moves(class_proficiency):
	var available_moves = AvailableMoves.new()

	var attack = RAM.new()

	var abilities = []

	if class_proficiency > 20:
		abilities.append(SIDE_SWIPE.new())

	if class_proficiency > 40:
		abilities.append(TBONE.new())

	available_moves.initialize_values(
		attack,
		[],
		abilities,
		[],
		[],
		""
	)

	return available_moves

