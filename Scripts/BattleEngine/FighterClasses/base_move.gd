class_name base_move


static func use_move(
	move_info, #{"move": Move,"user":Fighter,"target": Fighter}
	success_roll,
	crit_roll
):
	var move_type = move_info["move"].move_type

	var move = move_info["move"]
	var user = move_info["user"]
	var target = move_info["target"]


	var move_func = {
		"melee_attack": melee_attack,
		"gun_attack": gun_attack,
		"black_magic_attack": black_magic_attack,
		"white_magic_attack": white_magic_attack,
		"white_magic_healing": white_magic_healing,
		"item_attack": item_attack,
		"item_healing": item_healing,
	}.get(move_type, null) 
	
	if is_instance_valid(move_func) == false:
		print("BIG UFF the move_type key was not found: ", move_type)
		
	var move_results = move_func.call(move, user, target, success_roll, crit_roll)

	return move_results
			

static func melee_attack(move, user, target, success_roll, crit_roll):
	pass

static func gun_attack(move, user, target, success_roll, crit_roll):
	print("used gun attack")
	
static func black_magic_attack(move, user, target, success_roll, crit_roll):
	print("used black magic attack")
	pass

static func white_magic_attack(move, user, target, success_roll, crit_roll):
	pass

static func white_magic_healing(move, user, target, success_roll, crit_roll):
	pass

static func item_attack(move, user, target, success_roll, crit_roll):
	pass

static func item_healing(move, user, target, success_roll, crit_roll):
	pass

static func bp_cost_attempt(move, user, target, success_roll, crit_roll):
	var bp_cost = move.bp_cost
