class_name GunnerClass


static func get_available_moves(class_proficiency):

	var available_moves = [GUN_DOWN.new()]

	if class_proficiency > 20:
		available_moves.append(SPRAY_DOWN.new())

	if class_proficiency > 40:
		available_moves.append(BAZOOKA.new())

	return available_moves
