extends TextureProgressBar

@onready var player = get_tree().get_root().get_child(0).get_node("Player")

# Called when the node enters the scene tree for the first time.
func _ready():

	player.ready.connect(_on_player_ready)
	player._on_boost_used.connect(update_value)

func _process(_delta):
	pass

func update_value(val):
	value = val

func _on_player_ready():
	var max_boost = player.stats.max_boost
	var current_boost = player.stats.current_boost

	max_value = max_boost
	value = current_boost
