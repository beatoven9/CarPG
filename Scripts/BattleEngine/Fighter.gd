extends Area2D

@onready var sprite2d: Sprite2D = get_node("Sprite2D")
@onready var collision_shape2d: CollisionShape2D = get_node("CollisionShape2D")
@onready var battle_timer = get_node("BattleTimer")

var fighter_name
var fighter_speed

signal move_ready(move)
signal ready_to_move

signal health_changed(value)
signal timer_changed(value)
signal boost_changed(value)

func get_battle_timer_length():
	var timer_length = fighter_speed * .50
	return timer_length

func set_data(
	new_fighter_name,
	texture: Texture2D,
	speed: int
):
	fighter_name = new_fighter_name
	get_node("Sprite2D").set_texture(texture)
	fighter_speed = speed

func _ready():
	battle_timer.battle_timer_out.connect(_timer_out)
	set_collision_box_size()

func update_timer_bar():
	var time_left = battle_timer.time_left
	var max_time = get_battle_timer_length()
	var timer_bar_val = 100 - ((time_left / max_time) * 100)
	timer_changed.emit(timer_bar_val)

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
	var move = {
		"move_name": "punch_attack",
		"base_power": 80,
		}

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
	battle_timer.set_paused(true)

func resume_timer():
	battle_timer.set_paused(false)
