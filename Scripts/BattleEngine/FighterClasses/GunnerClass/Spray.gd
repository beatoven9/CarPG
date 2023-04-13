extends base_move
class_name SPRAY_DOWN

var move_name = "Spray"
var base_power = 40
# var move_type = MOVE_TYPE.GUN_ATTACK
var move_type = "gun_attack"
# var target_type = TARGET_TYPE.ALL_ENEMIES
var sub_selection = ["Single Target", "All Targets"]
var bp_cost = 10
var friendly = false
var crit_rate = .25
