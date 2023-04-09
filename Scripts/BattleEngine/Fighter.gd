extends Area2D

@onready var sprite2d: Sprite2D = get_node("Sprite2D")
@onready var collision_shape2d: CollisionShape2D = get_node("CollisionShape2D")
@onready var battle_timer = get_node("BattleTimer")
@onready var selected_ui = get_node("SelectedSprite")

var fighter_hud
var fighter_name
var fighter_speed
var fighter_class
var class_proficiency

signal move_ready(move, user, target)
signal ready_to_move

signal health_changed(value)
signal timer_changed(value)
signal boost_changed(value)

func get_battle_timer_length():
	var timer_length = fighter_speed * .50
	return timer_length

func set_data(
	data
):
	fighter_name = data["name"]
	get_node("Sprite2D").set_texture(data["texture"])
	fighter_speed = data["speed"]
	fighter_class = data["fighter_class"]
	class_proficiency = data["class_proficiency"]

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
	battle_timer.set_paused(true)

func resume_timer():
	battle_timer.set_paused(false)

func handle_move_receipt(move):
	if move.move_type == MOVE_TYPE.LONG_RANGE_ATTACK:
		var damage_inflicted = (move.base_power / 10)
		health_changed.emit(-damage_inflicted)	

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
