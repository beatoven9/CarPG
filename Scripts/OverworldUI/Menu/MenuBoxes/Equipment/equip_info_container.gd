extends MarginContainer


@onready var name_label: Label = $MarginContainer/VBoxContainer/ItemNameContainer/Name
@onready var effect_label: Label = $MarginContainer/VBoxContainer/ItemInfoContainer/ItemInfoContainer/MarginContainer/VBoxContainer/EffectContainer/Value
@onready var description_label: Label = $MarginContainer/VBoxContainer/ItemInfoContainer/ItemInfoContainer/MarginContainer/VBoxContainer/DescriptionContainer/Value
@onready var level_label: Label = $MarginContainer/VBoxContainer/ItemInfoContainer/ExpContainer/MarginContainer/ExpContainer/LevelContainer/Value
@onready var current_exp_label: Label = $MarginContainer/VBoxContainer/ItemInfoContainer/ExpContainer/MarginContainer/ExpContainer/CurrentExpContainer/Value
@onready var next_lvl_exp_label: Label = $MarginContainer/VBoxContainer/ItemInfoContainer/ExpContainer/MarginContainer/ExpContainer/NextLevelContainer/Value


func set_name_label(text: String):
	name_label.set_text(text)

func set_description_label(text: String):
	description_label.set_text(text)	

func set_effect_label(text: String):
	effect_label.set_text(text)

func set_level_label(num: int):
	level_label.set_text(str(num))

func set_current_exp_label(num: int):
	current_exp_label.set_text(str(num))

func set_next_lvl_exp_label(num: int):
	next_lvl_exp_label.set_text(str(num))

func clear_info():
	set_name_label(" ")
	set_description_label("")
	set_effect_label("")
	set_level_label(0)
	set_current_exp_label(0)
	set_next_lvl_exp_label(0)

func set_item_info(item):
	set_name_label(item.get_name_string())
	set_description_label(item.get_description())
	set_effect_label(item.get_effect())
	set_level_label(item.get_level())
	set_current_exp_label(item.get_current_exp())
	set_next_lvl_exp_label(item.get_exp_to_next_level())
