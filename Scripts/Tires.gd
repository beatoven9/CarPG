extends Node2D

@onready var tire_left = get_node("Left")
@onready var tire_right = get_node("Right")
@onready var tire_sprite = get_node("Left").get_node("TireSprite")

@onready var car = get_parent()

func _ready():
	pass
	# var tire_sprite = tire_left.get_node("TireSprite")
	# set_axle_width(car.get_axle_width_pixels(), tire_sprite)

func get_tire_width(_tire_sprite):
	var tire_rect = _tire_sprite.get_rect()
	var tire_position = tire_rect.position
	var tire_end = tire_rect.end
	var tire_width = tire_end.x - tire_position.x 
	return tire_width

func set_axle_width(axle_width_pixels, _tire_sprite):
	var axle_half_width = float(axle_width_pixels) / 2
	var tire_half_width = get_tire_width(_tire_sprite) / 2
	tire_left.position.y = axle_half_width + tire_half_width
	tire_right.position.y = -axle_half_width - tire_half_width


func set_wheel_rotation(wheel_rotation):
	tire_left.rotation = wheel_rotation
	tire_right.rotation = wheel_rotation

func fix_axle_width():
	set_axle_width(car.get_axle_width_pixels(), tire_sprite)
