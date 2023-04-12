extends Label

var timer: Timer

# Called when the node enters the scene tree for the first time.
func _ready():
	timer = Timer.new()
	timer.set_one_shot(true)
	timer.timeout.connect(_display_timer_out)
	add_child(timer)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func display_damage(damage_inflicted, critical_hit):
	if critical_hit:
		material.set_shader_parameter("critical", true)

	else:
		material.set_shader_parameter("critical", false)
	set_text(str(damage_inflicted))
	timer.start(2)
	set_visible(true)

func _display_timer_out():
	set_visible(false)
