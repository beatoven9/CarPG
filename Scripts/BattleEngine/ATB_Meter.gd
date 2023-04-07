extends VBoxContainer

@onready var progress_bar: TextureProgressBar = $TextureProgressBar
@onready var label: RichTextLabel = $RichTextLabel


func update_progress_bar(value):
	progress_bar.value = value

func set_fighter_name(fighter_name):
	label.text = fighter_name

func _ready():
	pass
