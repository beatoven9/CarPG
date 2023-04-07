extends MarginContainer

@onready var fighter_name_label: RichTextLabel = $MarginContainer/VBoxContainer/FighterName/RichTextLabel
@onready var health_bar: TextureProgressBar = $MarginContainer/VBoxContainer/HealthHUD/HBoxContainer/Gauge
@onready var boost_bar: TextureProgressBar = $MarginContainer/VBoxContainer/BoostHUD/HBoxContainer/Gauge
@onready var battle_timer_progress: TextureProgressBar = $MarginContainer/VBoxContainer/BattleTimerHUD/HBoxContainer/Gauge

var fighter_name

func update_timer_bar(value):
	battle_timer_progress.value = value

func update_boost_bar(value):
	boost_bar.value = value

func update_health_bar(value):
	# Maybe vitality can be how quickly the gauge falls (lerping)
	health_bar.value = value

func set_fighter_name(this_fighter_name):
	if this_fighter_name == null:
		fighter_name_label.set_text("LARRY")
	else:
		fighter_name_label.set_text(fighter_name)

func _ready():
	set_fighter_name(fighter_name)
