class_name ThiefClass


static func get_available_moves(class_proficiency):
	var available_moves = AvailableMoves.new()

	var attack = KEY_CAR.new()

	var abilities = []

	if class_proficiency > 20:
		abilities.append(STEAL.new())

	if class_proficiency > 40:
		abilities.append(MUG.new())

	available_moves.initialize_values(
		attack,
		[],
		abilities,
		[],
		[],
		""
	)

	return available_moves

