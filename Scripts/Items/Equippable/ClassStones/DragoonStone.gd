extends BaseClassStone
class_name DragoonStone



@onready var icon_texture: Texture2D = preload("res://Sprites/UI_Sprites/Items/ClassStones/DragoonStone.png")

var fighter_class = FIGHTER_CLASSES.DRAGOON
var local_description = "This stone grants you the ability to play as the Dragoon Class."
var local_name = "Dragoon Stone"

func _init():
	set_name_string(local_name)
	set_description(local_description)

func _ready():
	super._ready()
	set_icon_texture(icon_texture)

static func get_available_moves(class_proficiency):
	var available_moves = AvailableMoves.new()

	var attack = JUMP_PREP.new()

	var abilities = []
	var magic = []

	if class_proficiency > 20:
		abilities.append(JUMP_HIGH_PREP.new())

	if class_proficiency > 40:
		abilities.append(SWIPE.new())

	available_moves.set_attack_move(attack)
	available_moves.set_magic_moves(magic)
	available_moves.set_ability_moves(abilities)

	return available_moves

