extends Area2D

@onready var sprite2d: Sprite2D = get_node("Sprite2D")
@onready var collision_shape2d: CollisionShape2D = get_node("CollisionShape2D")
@onready var battle_timer = get_node("BattleTimer")
@onready var selected_ui = get_node("SelectedSprite")
@onready var damage_hud = $DamageHUD

var second_tick_timer: Timer

var fighter_hud
var fighter_name
var fighter_speed
var fighter_class
var class_proficiency
var boost_per_sec
var health_per_sec
var max_health
var current_health
var max_boost
var current_boost

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
	fighter_speed = data["speed"]
	fighter_class = data["fighter_class"]
	class_proficiency = data["class_proficiency"]

	max_health = data["max_health"]
	current_health = max_health
	max_boost = data["max_boost"]
	current_boost = max_boost
	boost_per_sec = data["boost_per_sec"]
	health_per_sec = data["health_per_sec"]

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

func handle_move_receipt(move):
	# This code should be using fighter stats to determine
	# how much damage should be done

	var damage_inflicted
	var critical

	if move.move_type == MOVE_TYPE.LONG_RANGE_ATTACK:
		damage_inflicted = (move.base_power / 10)

	elif move.move_type == MOVE_TYPE.BLACK_MAGIC_ATTACK:
		damage_inflicted = (move.base_power / 10)


	var random = RandomNumberGenerator.new()
	random.randomize()

	critical = false if (random.randfn() < 0) else true
	
	if critical:
		damage_inflicted += 10

	handle_damage(damage_inflicted, critical)

	return damage_inflicted

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
