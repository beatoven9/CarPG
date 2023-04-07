extends Timer


signal battle_timer_out(fighter)

@onready var fighter = get_parent()

func _ready():
	timeout.connect(_on_battle_timer_out)

func _on_battle_timer_out():
	battle_timer_out.emit(fighter)

func start_timer(time: int):
	start(time)
