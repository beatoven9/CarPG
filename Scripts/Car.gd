extends CharacterBody2D

var is_boosting = false
var fuel_usage_multiplier = .0001
var wheel_rotation = 0
var speed = 0
var extra_thrust = 1
var movement_rotation = 0
var movement_direction = 1
var rotation_direction = 0
@onready var tires = get_node("Tires")
@onready var stats = get_node("Stats")


# returns boost_power if there is boost left.
func use_boost(boost_used, boost_is_true, delta):
	if (stats.current_boost > 0) && (boost_is_true == true):
		stats.current_boost -= boost_used * delta
		return stats.current_boost_power
	else:
		return 1

func get_input():
	var accelerator = 0
	var wheel_rotation_delta = 0
	return {
		"accelerator": accelerator,
		"wheel_rotation_delta": wheel_rotation_delta
	}


func get_axel_width_pixels():
	var car_sprite = get_node("CarSprite")
	var car_rect = car_sprite.get_rect()
	var car_position = car_rect.position
	var car_end = car_rect.end
	var car_width = car_position.x - car_end.x
	return car_width
	
func manage_wheel_rotation(delta, wheel_rotation_delta):
	wheel_rotation += wheel_rotation_delta
	wheel_rotation = clamp(wheel_rotation, -stats.max_rotation, stats.max_rotation)
	if wheel_rotation_delta == 0:
		wheel_rotation = lerpf(0, wheel_rotation, pow(2, -40 * delta))
	tires.set_wheel_rotation(wheel_rotation)

func _physics_process(delta):
	var input_dict = get_input()
	manage_wheel_rotation(delta, input_dict["wheel_rotation_delta"])
	move(delta, input_dict["accelerator"])


func calculate_fuel_usage(vel):
	var fuel_usage = vel.length() * fuel_usage_multiplier * (1/stats.current_fuel_efficiency)
	stats.current_fuel -= fuel_usage

func move(delta, accelerator):
	if velocity != Vector2.ZERO and stats.current_fuel > 0:
		rotation += movement_rotation * .1 * movement_direction
		calculate_fuel_usage(velocity)
		
	if accelerator == 0 or stats.current_fuel <= 0:
		velocity = lerp(
			Vector2.ZERO,
			velocity,
			pow(2, -10 * delta)
		)
		movement_rotation = lerpf(
			0,
			movement_rotation,
			pow(2, -5 * delta)
		)
	else:
		velocity = lerp(
			transform.x * accelerator * speed * extra_thrust,
			velocity,
			pow(2, -10 * delta)
		)
		movement_rotation = wheel_rotation

	if velocity.length() < 10:
		movement_rotation = 0
		velocity = Vector2.ZERO

	move_and_slide()
