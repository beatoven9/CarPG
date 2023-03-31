extends TextureRect

var max_angle_radians = 8.5
var min_angle_radians = 4
var radian_range = max_angle_radians - min_angle_radians

@onready var needle = get_node("Needle")
@onready var tree = get_tree().get_root()
@onready var player_stats = get_tree().get_root().get_child(0).get_node("Player").get_node("Stats")


func calculate_angle_radians(current_fuel):
	var max_fuel = player_stats.max_fuel
	var fuel_percentage = current_fuel/max_fuel
	var angle_above_min = radian_range * fuel_percentage
	var new_angle = min_angle_radians + angle_above_min
	return new_angle
	

func _ready():
	print("Needle is: ", needle)
	pass


func _process(_delta):
	needle.rotation = calculate_angle_radians(player_stats.current_fuel)
