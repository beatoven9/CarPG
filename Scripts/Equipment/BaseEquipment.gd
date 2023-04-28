extends BaseItem
class_name BaseEquipment

@onready var texture_rect: TextureRect
var item_type = ITEM_TYPES.EQUIP

func _ready():
	texture_rect = TextureRect.new()
	add_child(texture_rect)

func set_icon_texture(new_texture: Texture2D):
	texture_rect.set_texture(new_texture)
	texture_rect.set_anchors_preset(TextureRect.PRESET_FULL_RECT)
	texture_rect.set_stretch_mode(TextureRect.STRETCH_KEEP_ASPECT)

func get_icon_texture():
	return texture_rect.get_texture()

