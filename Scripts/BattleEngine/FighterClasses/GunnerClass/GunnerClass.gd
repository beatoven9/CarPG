class_name GunnerClass


static func get_available_moves(class_proficiency):
	var available_moves = AvailableMoves.new()

	var attack = GUN_DOWN.new()

	var abilities = []

	if class_proficiency > 20:
		abilities.append(SPRAY_DOWN.new())

	if class_proficiency > 40:
		abilities.append(BAZOOKA.new())

	available_moves.initialize_values(
		attack,
		[],
		abilities,
		[],
		[],
		""
	)

	return available_moves
