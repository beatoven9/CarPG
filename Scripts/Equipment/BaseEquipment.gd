extends MarginContainer
class_name BaseEquipment

@onready var texture_rect: TextureRect
var name_string = "equipment name"

func _ready():
	texture_rect = TextureRect.new()
	add_child(texture_rect)

func set_icon_texture(new_texture: Texture2D):
	texture_rect.set_texture(new_texture)
	texture_rect.set_anchors_preset(TextureRect.PRESET_FULL_RECT)
	texture_rect.set_stretch_mode(TextureRect.STRETCH_KEEP_ASPECT)

func get_icon_texture():
	return texture_rect.get_texture()

func get_name_string():
	return name_string

func set_name_string(new_name: String):
	name_string = new_name

