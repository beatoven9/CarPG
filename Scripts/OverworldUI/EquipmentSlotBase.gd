extends MarginContainer

@onready var slot_button = $VBoxContainer/MarginContainer/Button
signal slot_pressed

@onready var generic_popup = preload("res://Scenes/Overworld_UI/Popups/generic_popup.tscn")

func _ready():
	slot_button.pressed.connect(_on_slot_pressed)

func _on_slot_pressed():
	slot_pressed.emit(self)
