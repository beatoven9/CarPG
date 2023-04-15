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
	move_info["resume_timers"].call()
	var announcement_string = move_info["move"].generate_announcement_string(move_info)
	move_info["announcer_box"].make_announcement(announcement_string)
	queue_free()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
