extends MarginContainer

@onready var fighter_name_label: RichTextLabel = $MarginContainer/VBoxContainer/FighterName/RichTextLabel
@onready var health_bar: TextureProgressBar = $MarginContainer/VBoxContainer/HealthHUD/HBoxContainer/Gauge
@onready var health_bar_label: Label = $MarginContainer/VBoxContainer/HealthHUD/HBoxContainer/GaugeValueLabel
@onready var boost_bar: TextureProgressBar = $MarginContainer/VBoxContainer/BoostHUD/HBoxContainer/Gauge
@onready var boost_bar_label: Label = $MarginContainer/VBoxContainer/BoostHUD/HBoxContainer/GaugeValueLabel
@onready var battle_timer_progress: TextureProgressBar = $MarginContainer/VBoxContainer/BattleTimerHUD/HBoxContainer/Gauge
@onready var box_frame: NinePatchRect = $BoxFrame

var fighter_name

func update_timer_bar(value):
	battle_timer_progress.value = value

func update_boost_bar(current_boost, max_boost):
	var displayed_boost = (float(current_boost) / float(max_boost)) * 100.0
	boost_bar.value = displayed_boost
	var boost_label = str(current_boost) + "/" + str(max_boost)
	boost_bar_label.set_text(boost_label)

func update_health_bar(current_health, max_health):
	var displayed_health = (float(current_health) / float(max_health)) * 100.0
	health_bar.value = displayed_health
	var health_label = str(current_health) + "/" + str(max_health)
	health_bar_label.set_text(health_label)

func set_fighter_name(this_fighter_name):
	if this_fighter_name == null:
		fighter_name_label.set_text("LARRY")
	else:
		fighter_name_label.set_text(fighter_name)
	
func _on_fighter_selected():
	box_frame.material.set_shader_parameter("selected", true)

func _on_fighter_unselected():
	box_frame.material.set_shader_parameter("selected", false)

func _ready():
	set_fighter_name(fighter_name)
