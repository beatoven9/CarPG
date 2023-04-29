extends BaseClassStone
class_name BlackMageStone

@onready var icon_texture: Texture2D = preload("res://Sprites/UI_Sprites/Items/ClassStones/BlackMageStone.png")

var fighter_class = FIGHTER_CLASSES.BLACK_MAGE
var local_description = "This stone grants you the ability to play as the Black Mage Class."
var local_name = "Black Mage Stone"

func _init():
	set_name_string(local_name)
	set_description(local_description)

func _ready():
	super._ready()
	set_icon_texture(icon_texture)

static func get_available_moves(class_proficiency):
	var available_moves = AvailableMoves.new()

	var attack = SPIRIT.new()

	var magic = []
	var abilities = []

	if class_proficiency > 20:
		magic.append(FIRE.new())

	if class_proficiency > 40:
		magic.append(BLIZZARD.new())

	available_moves.set_attack_move(attack)
	available_moves.set_magic_moves(magic)
	available_moves.set_ability_moves(abilities)

	return available_moves
