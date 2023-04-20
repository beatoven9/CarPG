extends CharacterBody2D


const SPEED = 5000.0

func get_mov_vec() -> Vector2:
	
	var mov_vector = Vector2.ZERO
	
	if Input.is_action_pressed("left"):
		mov_vector += Vector2.LEFT
	if Input.is_action_pressed("right"):
		mov_vector += Vector2.RIGHT
	if Input.is_action_pressed("up"):
		mov_vector += Vector2.UP
	if Input.is_action_pressed("down"):
		mov_vector += Vector2.DOWN

	return mov_vector.normalized()

func _physics_process(delta):

	var mov_vec: Vector2 = get_mov_vec()

	velocity = mov_vec * SPEED * delta

	move_and_slide()
