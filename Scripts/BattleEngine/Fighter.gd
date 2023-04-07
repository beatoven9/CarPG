extends Area2D

@onready var sprite2d: Sprite2D = get_node("Sprite2D")
@onready var collision_shape2d: CollisionShape2D = get_node("CollisionShape2D")
var this_fighter_name
var fighter_speed

func set_data(
	fighter_name,
	texture: Texture2D,
	speed: int
):
	this_fighter_name = fighter_name
	get_node("Sprite2D").set_texture(texture)
	fighter_speed = speed

func _ready():
	print("I am ", this_fighter_name, " my speed is: ", fighter_speed)
	set_collision_box_size()

func set_collision_box_size():
	var car_rect = sprite2d.get_rect()
	collision_shape2d.shape.size = car_rect.size
