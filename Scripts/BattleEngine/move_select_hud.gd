extends MarginContainer


@onready var move_selection_root = $NinePatchRect/MarginContainer/Move_Selection_Root

func _ready():
	move_selection_root.grab_focus()
	move_selection_root.select(0)
