extends "res://Scripts/Car.gd"

signal _on_boost_used

func get_input():
	var accelerator = Input.get_axis("down", "up")
	var wheel_rotation_delta = Input.get_axis("left", "right") * stats.current_rotation_speed
	return {
		"accelerator": accelerator,
		"wheel_rotation_delta": wheel_rotation_delta
	}

func _ready():
	print("READY")

func _physics_process(delta):
	super._physics_process(delta)
	print(stats.current_boost)
	if is_boosting:
		_on_boost_used.emit(stats.current_boost)
	extra_thrust = use_boost(
		stats.current_boost_efficiency,
		is_boosting,
		delta
	)

func _input(event):
	if event.is_action_pressed("left"):
		pass
	elif event.is_action_pressed("right"):
		pass
	elif event.is_action_pressed("up"):
		movement_direction = 1
	elif event.is_action_pressed("down"):
		movement_direction = -1

	if event.is_action_pressed("boost"):
		is_boosting = true


	if event.is_action_released("left"):
		pass
	elif event.is_action_released("right"):
		pass
	elif event.is_action_released("up"):
		pass
	elif event.is_action_released("down"):
		pass

	if event.is_action_released("boost"):
		is_boosting = false

func _on_shifter_ready(shifter_value):
	speed = (shifter_value/100) * stats.max_speed

func _on_shifter_value_changed(value):
	speed = (value/100) * stats.max_speed
