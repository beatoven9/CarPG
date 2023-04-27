extends HBoxContainer

signal card_selected(party_member_card)
signal card_activated(party_member_card)

@onready var button = $PartyMemberCard/Button
@onready var name_label: Label = $PartyMemberCard/MarginContainer/HBoxContainer/Name
@onready var hp_label: Label = $PartyMemberCard/MarginContainer/HBoxContainer/HP
@onready var mp_label: Label = $PartyMemberCard/MarginContainer/HBoxContainer/MP
@onready var status_container: HBoxContainer = $PartyMemberCard/MarginContainer/HBoxContainer/HBoxContainer/StatusContainer

@onready var status_icon = preload("res://Scenes/Overworld_UI/PartyBox/status_icon.tscn")

@onready var poison_texture: Texture2D = preload("res://Sprites/UI_Sprites/StatusIcons/PoisonIcon.png")
@onready var blind_texture: Texture2D = preload("res://Sprites/UI_Sprites/StatusIcons/BlindIcon.png")
@onready var mute_texture: Texture2D = preload("res://Sprites/UI_Sprites/StatusIcons/MuteIcon.png")
@onready var sleep_texture: Texture2D = preload("res://Sprites/UI_Sprites/StatusIcons/SleepIcon.png")

@onready var status_texture_dict = {
	"poison": poison_texture,
	"blind": blind_texture,
	"mute": mute_texture,
	"sleep": sleep_texture
}

func _ready():
	button.focus_entered.connect(_on_focus_entered)
	button.pressed.connect(_on_button_pressed)


func _on_focus_entered():
	card_selected.emit(self)

func _on_button_pressed():
	card_activated.emit(self)

func set_card_info(party_member: PartyMember):
	set_hp_label(party_member.current_hp, party_member.max_hp)
	set_mp_label(party_member.current_mp, party_member.max_mp)

	set_status_icons(party_member.status)
	set_card_name(party_member.get_name_string())

func set_card_name(text: String):
	name_label.set_text(text)

func set_hp_label(current_hp, max_hp):
	var new_text = "HP: " + str(current_hp) + "/" + str(max_hp)
	hp_label.set_text(new_text)

func set_mp_label(current_mp, max_mp):
	var new_text = "MP: " + str(current_mp) + "/" + str(max_mp)
	mp_label.set_text(new_text)

func set_status_icons(status_dict):
	for icon in status_container.get_children():
		icon.queue_free()

	for key in status_dict.keys():
		if status_dict[key] == true:
			var new_icon = status_icon.instantiate()
			var new_texture = status_texture_dict[key]
			status_container.add_child(new_icon)
			new_icon.set_texture(new_texture)

