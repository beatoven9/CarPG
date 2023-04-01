extends TextureRect

var max_angle_radians = 8.5
var min_angle_radians = 4
var radian_range = max_angle_radians - min_angle_radians

@onready var needle = get_node("Needle")
@onready var tree = get_tree().get_root()
@onready var player = get_tree().get_root().get_child(0).get_node("Player")
var max_speed = 0


func calculate_needle_angle(speed):
	var speed_percentage = speed/max_speed
	var radians_above_min = radian_range * speed_percentage

	var needle_angle = min_angle_radians + radians_above_min
	needle.rotation = needle_angle


# Called when the node enters the scene tree for the first time.
func _ready():
	player.ready.connect(_on_player_ready)
	

func _on_player_ready():
	# This should not be calculated like this.
	# The game should have some sort of global soft speed limit
	# for the purpose of setting the gauge. However, if the player
	# improves their speed enough, the speed gauge will perform full
	# rotations
	max_speed = player.stats.max_speed * player.stats.current_boost_power

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	calculate_needle_angle(player.velocity.length())
