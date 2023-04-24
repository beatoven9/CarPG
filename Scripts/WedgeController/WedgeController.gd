extends CharacterBody2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

const SPEED = 5000.0
var last_dir: Vector2 = Vector2.ZERO

func get_mov_vec() -> Vector2:
	
	var mov_vector = Vector2.ZERO
	
	if Input.is_action_pressed("left"):
		mov_vector += Vector2.LEFT
		animated_sprite.animation = "walk_right"
		animated_sprite.set_flip_h(true)

	if Input.is_action_pressed("right"):
		mov_vector += Vector2.RIGHT
		animated_sprite.animation = "walk_right"
		animated_sprite.set_flip_h(false)

	if Input.is_action_pressed("up"):
		mov_vector += Vector2.UP
		animated_sprite.animation = "walk_right"

	if Input.is_action_pressed("down"):
		mov_vector += Vector2.DOWN
		animated_sprite.animation = "walk_right"

	return mov_vector.normalized()

func _physics_process(delta):

	var mov_vec: Vector2 = get_mov_vec()

	velocity = mov_vec * SPEED * delta

	if mov_vec == Vector2.ZERO:
		animated_sprite.play("idle")
	else:
		animated_sprite.play()

	move_and_slide()
