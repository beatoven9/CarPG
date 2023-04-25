extends MarginContainer

@onready var attack_label = $CharacterStatsContainer/CharacterStatContainer/AttackContainer/StatValue
@onready var defense_label = $CharacterStatsContainer/CharacterStatContainer/DefenseContainer/StatValue
@onready var magic_label = $CharacterStatsContainer/CharacterStatContainer/MagicContainer/StatValue
@onready var magic_defense_label = $CharacterStatsContainer/CharacterStatContainer/MagicDefenseContainer/StatValue
@onready var speed_label = $CharacterStatsContainer/CharacterStatContainer/SpeedContainer/StatValue

func set_stats(stats_dict):
	set_attack(stats_dict["attack"])
	set_defense(stats_dict["defense"])
	set_magic(stats_dict["magic"])
	set_magic_defense(stats_dict["magic_defense"])
	set_speed(stats_dict["speed"])

func set_attack(value):
	attack_label.set_text(str(value))

func set_defense(value):
	defense_label.set_text(str(value))

func set_magic(value):
	magic_label.set_text(str(value))

func set_magic_defense(value):
	magic_defense_label.set_text(str(value))

func set_speed(value):
	speed_label.set_text(str(value))
