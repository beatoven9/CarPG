extends BlackMagicBase
class_name FIRE

var move_name = "Fire"
var base_power = 90
var move_type = "black_magic_attack"
var friendly = false
var elemental_damage = ELEMENTAL_DAMAGE.FIRE
var bp_cost = 15
var crit_rate = 1.0
var steal_item = false

#func use_move(move_info, success_roll, crit_roll):
#	var user = move_info["user"]
#	var target = move_info["target"]
#	var move = move_info["move"]
#
#	var crit = false
#
#	if crit_roll < move.crit_rate:
#		crit = true
#	else:
#		crit = false
#
#	# Possibly, in here we may have to check for elemental powerup?
#	
#	var move_base_power = move.base_power
#	var damage_output = 0
#	var fighter_magic = user.fighter_magic
#	var weapon_bonus = user.weapon_bonus
#	if move_base_power > 0:
#		damage_output = fighter_magic + move_base_power + weapon_bonus
#	elif move_base_power == 0:
#		damage_output = 0
#
#	if crit:
#		damage_output += weapon_bonus
#
#	move_info["success"] = user.calculate_move_success(move_info, success_roll)
#	move_info["move_power"] = damage_output
#	move_info["critical"] = crit
#
#	return move_info
