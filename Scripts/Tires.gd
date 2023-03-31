extends Node2D

@onready var tire_left = get_node("Left")
@onready var tire_right = get_node("Right")

@onready var car = get_parent()

func _ready():
	var tire_sprite = tire_left.get_node("TireSprite")
	set_axel_width(car.get_axel_width_pixels(), tire_sprite)

func get_tire_width(tire_sprite):
	var tire_rect = tire_sprite.get_rect()
	var tire_position = tire_rect.position
	var tire_end = tire_rect.end
	var tire_width = tire_end.x - tire_position.x 
	return tire_width

func set_axel_width(axel_width_pixels, tire_sprite):
	var axel_half_width = float(axel_width_pixels) / 2
	var tire_half_width = get_tire_width(tire_sprite) / 2
	tire_left.position.y = axel_half_width + tire_half_width
	tire_right.position.y = -axel_half_width - tire_half_width


func set_wheel_rotation(wheel_rotation):
	tire_left.rotation = wheel_rotation
	tire_right.rotation = wheel_rotation
