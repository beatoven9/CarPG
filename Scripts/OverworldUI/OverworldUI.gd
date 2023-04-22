extends CanvasLayer

@onready var menu = $Menu

func _input(event):
	if event.is_action_pressed("menu-toggle"):
		menu.toggle_menu()


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
