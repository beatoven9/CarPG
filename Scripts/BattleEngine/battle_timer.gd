extends Timer


signal battle_timer_out(fighter)

@onready var fighter = get_parent()

func _ready():
	timeout.connect(battle_timer_timeout)

func battle_timer_timeout():
	battle_timer_out.emit(fighter)
