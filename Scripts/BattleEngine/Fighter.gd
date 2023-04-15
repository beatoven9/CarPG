extends Area2D

@onready var sprite2d: Sprite2D = get_node("Sprite2D")
@onready var collision_shape2d: CollisionShape2D = get_node("CollisionShape2D")
@onready var battle_timer = get_node("BattleTimer")
@onready var selected_ui = get_node("SelectedSprite")
@onready var damage_hud = $DamageHUD

@onready var fire_hit_anim = preload("res://Scenes/Battle/AttackAnims/fire_hit.tscn")

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

var move_queue = []

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
	var player_fighters = battle_state["player_fighters"]
	var move = GUN_DOWN.new()
	var move_info = gen_move_info(
		move,
		self,
		player_fighters[0]
	)
	{
		"move" = move,
		"user" = self,
		"target" = player_fighters.pick_random()
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

func handle_damage(move_info):
	var damage_inflicted = move_info["damage_incurred"]
	var critical = move_info["critical"]

	damage_hud.display_damage(damage_inflicted, critical)
	current_health -= damage_inflicted

	health_changed.emit(current_health, max_health)	

	if current_health <= 0:
		_on_death()	

func handle_healing(move_info):
	var damage_inflicted = move_info["damage_incurred"]
	var critical = move_info["critical"]

	damage_hud.display_damage(damage_inflicted, critical)
	current_health += damage_inflicted

	health_changed.emit(current_health, max_health)	

	# damage_hud.display_healing(healing_amount)
	# current_health += healing_amount

	# health_changed.emit(current_health, max_health)	

	if current_health >= max_health:
		current_health = max_health

func _on_move_ready(move, target):
	var move_info = gen_move_info(
		move,
		self,
		target
	)
	move_ready.emit(move_info)

func pop_move_from_queue():
	if len(move_queue) > 0:
		return move_queue.pop_back()
	else:
		print(fighter_name, "Tried to pop from an empty move_queue")

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
	move_info,
	success_roll,
	crit_roll
):
	var move = move_info["move"]
	var move_type = move.move_type

	if move_info["wait"] == true:
		move_info["wait"] = false
		return move_info
	else:
		var move_func = {
			"melee_attack": use_melee_attack,
			"gun_attack": use_gun_attack,
			"jump_attack": use_jump_attack,
			"black_magic_attack": use_black_magic_attack,
			"white_magic_attack": use_white_magic_attack,
			"white_magic_healing": use_white_magic_healing,
			"item_attack": use_item_attack,
			"item_healing": use_item_healing,
		}.get(move_type, null) 
		
		if move_func == null:
			print("BIG UFF the move_type key was not found: ", move_type)
			
		var move_results = move_func.call(move_info, success_roll, crit_roll)

		return move_results
			

func use_melee_attack(move_info, success_roll, crit_roll):
	return use_physical_attack(move_info, success_roll, crit_roll)

func use_gun_attack(move_info, success_roll, crit_roll):
	return use_physical_attack(move_info, success_roll, crit_roll)

func use_jump_attack(move_info, success_roll, crit_roll):
	var following_turn_move = use_physical_attack(
		move_info,
		success_roll,
		crit_roll
	)	
	move_queue.push_back(following_turn_move)	
	move_info["wait"] = true

	return move_info
	
func use_black_magic_attack(move_info, success_roll, crit_roll):
	return use_magic_attack(move_info, success_roll, crit_roll)

func use_white_magic_attack(move_info, success_roll, crit_roll):
	return use_magic_attack(move_info, success_roll, crit_roll)

func use_white_magic_healing(move_info, success_roll, crit_roll):
	return use_magic_healing(move_info, success_roll, crit_roll)

func use_item_attack(move_info, success_roll, crit_roll):
	pass

func use_item_healing(move_info, success_roll, crit_roll):
	pass

func calculate_move_success(move_info, success_roll):
	var bp_cost = move_info["move"].bp_cost

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
		


func use_physical_attack(move_info, success_roll, crit_roll):
	var move = move_info["move"]
	var crit = false

	if crit_roll < move.crit_rate:
		crit = true
	else:
		crit = false

	# Possibly, in here we may have to check for elemental powerup?

	var move_base_power = move.base_power
	var damage_output = 0
	if move_base_power > 0:
		damage_output = fighter_magic + move_base_power + weapon_bonus
	elif move_base_power == 0:
		damage_output = 0

	if crit:
		damage_output += weapon_bonus

	move_info["success"] = calculate_move_success(move_info, success_roll)
	move_info["move_power"] = damage_output
	move_info["critical"] = crit

	return move_info

func use_magic_attack(move_info, success_roll, crit_roll):
	var move = move_info["move"]
	var crit = false

	if crit_roll < move.crit_rate:
		crit = true
	else:
		crit = false

	# Possibly, in here we may have to check for elemental powerup?


	var move_base_power = move.base_power
	var damage_output = 0
	if move_base_power > 0:
		damage_output = fighter_magic + move_base_power + weapon_bonus
	elif move_base_power == 0:
		damage_output = 0

	if crit:
		damage_output += weapon_bonus

	move_info["success"] = calculate_move_success(move_info, success_roll)
	move_info["move_power"] = damage_output
	move_info["critical"] = crit

	return move_info

func use_magic_healing(move_info, success_roll, crit_roll):
	var move = move_info["move"]
	var crit = false

	if crit_roll < move.crit_rate:
		crit = true
	else:
		crit = false

	# Possibly, in here we may have to check for elemental powerup?


	var move_base_power = move.base_power
	var damage_output = 0
	if move_base_power > 0:
		damage_output = fighter_magic + move_base_power + weapon_bonus
	elif move_base_power == 0:
		damage_output = 0

	if crit:
		damage_output += weapon_bonus
	
	move_info["success"] = calculate_move_success(move_info, success_roll)
	move_info["move_power"] = damage_output
	move_info["critical"] = crit

	return move_info



func receive_move(
	move_info,
):
	var move = move_info["move"]
	var move_type = move.move_type
	var damage_output = move_info["move_power"]
	var crit = move_info["critical"]
	
	if damage_output == 0:
		move_info["damage_incurred"] = 0
		return move_info
	else:
		var move_func = {
			"melee_attack": receive_melee_attack,
			"gun_attack": receive_gun_attack,
			"jump_attack": receive_jump_attack,
			"black_magic_attack": receive_black_magic_attack,
			"white_magic_attack": receive_white_magic_attack,
			"white_magic_healing": receive_white_magic_healing,
			"item_attack": receive_item_attack,
			"item_healing": receive_item_healing,
		}.get(move_type, null) 
		
		if move_func == null:
			print("BIG UFF the move_type key was not found: ", move_type)
			
		var damage_incurred = move_func.call(move_info)
		#move_info["damage_incurred"] = damage_incurred

		return move_info
			

func receive_melee_attack(move_info):
	return receive_physical_attack(move_info)

func receive_gun_attack(move_info):
	return receive_physical_attack(move_info)

func receive_jump_attack(move_info):
	return receive_physical_attack(move_info)
	
func receive_black_magic_attack(move_info):
	var animation_string = {
		"Frost": "frost_hit",
		"Fire": "fire_hit",
		"Zap": "zap_hit",
		"Spirit": "spirit_hit"
	}[move_info["move"].move_name]

	move_info["damage_incurred"] = receive_magic_attack(move_info)
	var damage_output = move_info["move_power"]

	var damage_incurred = damage_output - fighter_magic_defense
	
	if damage_incurred < 0:
		damage_incurred = 0

	damage_incurred = int(damage_incurred)


	var hit_anim_node = fire_hit_anim.instantiate()

	hit_anim_node.move_info = move_info

	move_info["target"].add_child(hit_anim_node)

	hit_anim_node.spell_finished.connect(
		move_info["target"].handle_damage
	)

	hit_anim_node.animated_sprite.play(animation_string)

	return move_info

func receive_white_magic_attack(move_info):
	return receive_magic_attack(move_info)

func receive_white_magic_healing(move_info):
	var animation_string = {
		"Cure": "cure_hit"
	}[move_info["move"].move_name]

	move_info["damage_incurred"] = receive_magic_attack(move_info)
	var damage_output = move_info["move_power"]

	var damage_incurred = damage_output - fighter_magic_defense
	
	damage_incurred = int(damage_incurred)


	var hit_anim_node = fire_hit_anim.instantiate()

	hit_anim_node.move_info = move_info

	move_info["target"].add_child(hit_anim_node)

	hit_anim_node.spell_finished.connect(
		move_info["target"].handle_healing
	)

	hit_anim_node.animated_sprite.play(animation_string)

	return move_info

func receive_item_attack(move_info):
	pass

func receive_item_healing(move_info):
	pass

func receive_physical_attack(move_info):
	var damage_output = move_info["move_power"]
	var crit = move_info["critical"]
	var damage_incurred = damage_output - fighter_magic_defense
	
	if damage_incurred < 0:
		damage_incurred = 0

	damage_incurred = int(damage_incurred)
	handle_damage(move_info)
	return damage_incurred

func receive_magic_attack(move_info):
	var damage_output = move_info["move_power"]
	var crit = move_info["critical"]
	var damage_incurred = damage_output - fighter_magic_defense
	
	# This is necessary because if the magic defense is higher than the damage_output, we don't want healing to occur
	# We could clamp the value instead
	if damage_incurred < 0:
		damage_incurred = 0

	damage_incurred = int(damage_incurred)
	return damage_incurred

func receive_magic_healing(move_info):
	var damage_output = move_info["move_power"]
	var crit = move_info["critical"]
	var damage_incurred = damage_output

	return damage_incurred

func gen_move_info(
	move,
	user,
	target,
):
	var move_info = {
		"move": move,
		"user": user,
		"target": target,
		"stolen_item": "",
		"critical": false,
		"move_power": 0,
		"damage_incurred": 0,
		"wait": false,
		"announcer_box": null,
		"resume_timer_method": null

	}

	return move_info
