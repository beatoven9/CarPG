extends Node

# Static stats
var max_health = 100
var max_speed = 400
var max_fuel = 1000
var max_boost = 60
var max_boost_power = 2
var max_boost_efficiency = 1
var max_fuel_efficiency = .5
var max_acceleration = 1
var max_rotation = 1
var handling = 1
var max_rotation_speed = .1
var base_turn_tightness = .04
var tight_turn_tightness = .08

# Dynamic stats
var current_fuel
var current_max_speed
var current_health
var current_boost
var current_boost_power
var current_boost_efficiency
var current_fuel_efficiency
var current_acceleration
var current_rotation_speed
var shifter_position

func _ready():
	current_fuel = max_fuel
	current_max_speed = max_speed
	current_health = max_health
	current_boost = max_boost
	current_boost_power = max_boost_power
	current_boost_efficiency = max_boost_efficiency
	current_fuel_efficiency = max_fuel_efficiency
	current_acceleration = max_acceleration
	current_rotation_speed = max_rotation_speed


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
