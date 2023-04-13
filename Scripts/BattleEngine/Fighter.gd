extends Area2D

@onready var sprite2d: Sprite2D = get_node("Sprite2D")
@onready var collision_shape2d: CollisionShape2D = get_node("CollisionShape2D")
@onready var battle_timer = get_node("BattleTimer")
@onready var selected_ui = get_node("SelectedSprite")
@onready var damage_hud = $DamageHUD

var second_tick_timer: Timer

var max_health
var current_health
var max_boost
var current_boost
var boost_per_sec
var health_per_sec

var fighter_attack
var fighter_defense
var fighter_magic
var fighter_magic_defense
var fighter_speed
var fighter_luck
var fighter_vitality

var inventory = []
var snatchable_inventory = []
var weapon_bonus = 0
var armor_bonus = 0

var fighter_hud
var fighter_name
var fighter_class
var class_proficiency

var dead = false

signal move_ready(move, user, target)
signal ready_to_move

signal health_changed(value)
signal timer_changed(value)
signal boost_changed(value)
signal fighter_death(fighter)

func get_battle_timer_length():
	var timer_length = (100.0/fighter_speed)
	return timer_length

func set_data(
	data
):
	fighter_name = data["name"]
	get_node("Sprite2D").set_texture(data["texture"])
	fighter_class = data["fighter_class"]
	class_proficiency = data["class_proficiency"]

	fighter_attack = data["attack"]
	fighter_defense = data["defense"]
	fighter_magic = data["magic"]
	fighter_magic_defense = data["magic_defense"]
	fighter_speed = data["speed"]
	fighter_luck = data["luck"]
	fighter_vitality = data["vitality"]

	max_health = data["max_health"]
	current_health = max_health
	max_boost = data["max_boost"]
	current_boost = max_boost
	boost_per_sec = data["boost_per_sec"]
	health_per_sec = data["health_per_sec"]

	weapon_bonus = data["weapon_bonus"]
	armor_bonus = data["armor_bonus"]
	inventory = data["inventory"]
	snatchable_inventory = data["snatchable_inventory"]

func _ready():
	battle_timer.battle_timer_out.connect(_timer_out)
	second_tick_timer = Timer.new()
	second_tick_timer.timeout.connect(_on_second_tick)
	add_child(second_tick_timer)
	second_tick_timer.start(1)
	set_collision_box_size()

func update_timer_bar():
	var time_left = battle_timer.time_left
	var max_time = get_battle_timer_length()
	var timer_bar_val = 100 - ((time_left / max_time) * 100)
	timer_changed.emit(timer_bar_val)

func update_hud():
	fighter_hud.update_health_bar(current_health, max_health)
	fighter_hud.update_boost_bar(current_boost, max_boost)
	

func _process(_delta):
	update_timer_bar()

func set_collision_box_size():
	var car_rect = sprite2d.get_rect()
	collision_shape2d.shape.size = car_rect.size

func start_battle_timer():
	var time = get_battle_timer_length()
	battle_timer.start_timer(time)

func request_move(battle_state):
	var enemy_fighters = battle_state["enemy_fighters"]
	var move = GUN_DOWN.new()
	var move_info = {
		"move" = move,
		"user" = self,
		"target" = enemy_fighters[0]
	}
	move_ready.emit(move_info)

func send_move():
	pass

func _timer_out(fighter):
	ready_to_move.emit(fighter)

func pause_timer():
	second_tick_timer.set_paused(true)
	battle_timer.set_paused(true)

func resume_timer():
	second_tick_timer.set_paused(false)
	battle_timer.set_paused(false)

# func handle_move_receipt(move):
# 	# This code should be using fighter stats to determine
# 	# how much damage should be done
# 
# 	var damage_inflicted
# 	var critical
# 
# 	if move.move_type == MOVE_TYPE.LONG_RANGE_ATTACK:
# 		damage_inflicted = (move.base_power) - fighter_defense
# 
# 	elif move.move_type == MOVE_TYPE.BLACK_MAGIC_ATTACK:
# 		damage_inflicted = (move.base_power) - fighter_magic_defense
# 
# 
# 	var random = RandomNumberGenerator.new()
# 	random.randomize()
# 
# 	critical = false if (random.randfn() < 0) else true
# 	
# 	if critical:
# 		damage_inflicted += 10
# 
# 	handle_damage(damage_inflicted, critical)
# 
# 	return damage_inflicted

func handle_damage(damage_inflicted, critical):

	damage_hud.display_damage(damage_inflicted, critical)
	current_health -= damage_inflicted

	health_changed.emit(current_health, max_health)	

	if current_health <= 0:
		_on_death()	

func _on_move_ready(move, target):
	var move_info = {
		"move": move,
		"user": self,
		"target": target
	}
	move_ready.emit(move_info)

func get_unselected():
	fighter_hud._on_fighter_unselected()
	selected_ui.set_visible(false)
	selected_ui.stop()

func get_selected():
	fighter_hud._on_fighter_selected()
	selected_ui.set_visible(true)
	selected_ui.play()

func _on_death():
	sprite2d.set_visible(false)	
	current_health = 0
	dead = true
	health_changed.emit(current_health, max_health)
	battle_timer.stop()
	fighter_death.emit(self)	

func expend_bp(bp_cost):
	if current_boost > bp_cost:
		current_boost -= bp_cost	
		boost_changed.emit(current_boost, max_boost)
		return true
	else:
		current_boost = 0
		boost_changed.emit(current_boost, max_boost)
		return false

func _on_second_tick():
	current_boost += boost_per_sec
	if current_boost >= max_boost:
		current_boost = max_boost
	current_health += health_per_sec
	if current_health >= max_health:
		current_health = max_health

	fighter_hud.update_health_bar(current_health, max_health)
	fighter_hud.update_boost_bar(current_boost, max_boost)





func use_move(
	move,
	success_roll,
	crit_roll
):
	var move_type = move.move_type


	var move_func = {
		"melee_attack": use_melee_attack,
		"gun_attack": use_gun_attack,
		"black_magic_attack": use_black_magic_attack,
		"white_magic_attack": use_white_magic_attack,
		"white_magic_healing": use_white_magic_healing,
		"item_attack": use_item_attack,
		"item_healing": use_item_healing,
	}.get(move_type, null) 
	
	if move_func == null:
		print("BIG UFF the move_type key was not found: ", move_type)
		
	var move_results = move_func.call(move, success_roll, crit_roll)

	return move_results
			

func use_melee_attack(move, success_roll, crit_roll):
	return use_physical_attack(move, success_roll, crit_roll)

func use_gun_attack(move, success_roll, crit_roll):
	return use_physical_attack(move, success_roll, crit_roll)
	
func use_black_magic_attack(move, success_roll, crit_roll):
	return use_magic_attack(move, success_roll, crit_roll)

func use_white_magic_attack(move, success_roll, crit_roll):
	return use_magic_attack(move, success_roll, crit_roll)

func use_white_magic_healing(move, success_roll, crit_roll):
	return use_magic_healing(move, success_roll, crit_roll)

func use_item_attack(move, success_roll, crit_roll):
	pass

func use_item_healing(move, success_roll, crit_roll):
	pass

func calculate_move_success(move, success_roll):
	var bp_cost = move.bp_cost

	if current_boost >= bp_cost:
		current_boost -= bp_cost
		fighter_hud.update_boost_bar(current_boost, max_boost)
		return true
	else:
		var diff = bp_cost - current_boost
		var ratio = diff / bp_cost
		if success_roll < ratio:
			# There is another steal check on the targetted fighter which selects which item the player receives
			# One of the items should be "spare change" or "pocket lint" as a euphemism for "failure".
			# Inventory will be a list of objects on all fighters. It will be set when a fighter is instantiated.
			# Then, GetStolen from will choose from this list at random.
			# It will not remove old items from list.
			return true
		else:
			return false
		


func use_physical_attack(move, success_roll, crit_roll):
	var crit = false

	if crit_roll < move.crit_rate:
		crit = true
	else:
		crit = false

	# Possibly, in here we may have to check for elemental powerup?

	var move_base_power = move.base_power
	var damage_output = fighter_attack + move_base_power

	if crit:
		damage_output *= 1.1

	var success = calculate_move_success(move, success_roll)

	return {
		"damage_output": damage_output,
		"crit": crit,
		"success": success
	}

func use_magic_attack(move, success_roll, crit_roll):
	var crit = false

	if crit_roll < move.crit_rate:
		crit = true
	else:
		crit = false

	# Possibly, in here we may have to check for elemental powerup?


	var move_base_power = move.base_power
	var damage_output = fighter_magic + move_base_power

	if crit:
		damage_output *= 1.1

	var success = calculate_move_success(move, success_roll)

	return {
		"damage_output": damage_output,
		"crit": crit,
		"success": success
	}

func use_magic_healing(move, success_roll, crit_roll):
	var crit = false

	if crit_roll < move.crit_rate:
		crit = true
	else:
		crit = false

	# Possibly, in here we may have to check for elemental powerup?


	var move_base_power = move.base_power
	var damage_output = fighter_magic + move_base_power

	if crit:
		damage_output *= 1.1
	
	var damage = damage_output * -1
	var success = calculate_move_success(move, success_roll)

	return {
		"damage_output": damage,
		"crit": crit,
		"success": success
	}



func receive_move(
	move,
	move_output
):
	var move_type = move.move_type
	var damage_output = move_output["damage_output"]
	var crit = move_output["crit"]

	var move_func = {
		"melee_attack": receive_melee_attack,
		"gun_attack": receive_gun_attack,
		"black_magic_attack": receive_black_magic_attack,
		"white_magic_attack": receive_white_magic_attack,
		"white_magic_healing": receive_white_magic_healing,
		"item_attack": receive_item_attack,
		"item_healing": receive_item_healing,
	}.get(move_type, null) 
	
	if move_func == null:
		print("BIG UFF the move_type key was not found: ", move_type)
		
	var move_results = move_func.call(move, damage_output, crit)

	return move_results
			

func receive_melee_attack(move, damage_output, crit):
	return receive_physical_attack(move, damage_output, crit)

func receive_gun_attack(move, damage_output, crit):
	return receive_physical_attack(move, damage_output, crit)
	
func receive_black_magic_attack(move, damage_output, crit):
	return receive_magic_attack(move, damage_output, crit)

func receive_white_magic_attack(move, damage_output, crit):
	return receive_magic_attack(move, damage_output, crit)

func receive_white_magic_healing(move, damage_output, crit):
	return receive_magic_healing(move, damage_output, crit)

func receive_item_attack(move, damage_output, crit):
	pass

func receive_item_healing(move, damage_output, crit):
	pass

func receive_physical_attack(move, damage_output, crit):
	var damage_incurred = damage_output - fighter_magic_defense
	
	if damage_incurred < 0:
		damage_incurred = 0

	damage_incurred = int(damage_incurred)
	handle_damage(damage_incurred, crit)
	return damage_incurred

func receive_magic_attack(move, damage_output, crit):
	var damage_incurred = damage_output - fighter_magic_defense
	
	if damage_incurred < 0:
		damage_incurred = 0

	damage_incurred = int(damage_incurred)
	handle_damage(damage_incurred, crit)
	return damage_incurred

func receive_magic_healing(move, damage_output, crit):
	var damage_incurred = damage_output
		
	handle_damage(damage_incurred, crit)

	return damage_incurred
