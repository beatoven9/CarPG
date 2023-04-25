extends CanvasLayer

@onready var menu = $Menu

func _input(event):
	if event.is_action_pressed("menu-toggle"):
		menu.open_menu(get_ui_data())



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func get_ui_data():
	return {}
