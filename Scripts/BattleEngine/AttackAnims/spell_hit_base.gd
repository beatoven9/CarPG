extends Node2D

signal spell_finished(move_info)
var move_info

@onready var animated_sprite = $SpellAnim

# Called when the node enters the scene tree for the first time.
func _ready():
	animated_sprite.animation_looped.connect(_on_anim_finished)

func _on_anim_finished():
	spell_finished.emit(move_info)
	animated_sprite.stop()
	queue_free()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
