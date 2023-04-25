extends HBoxContainer

signal card_selected(party_member_card)
signal card_activated(party_member_card)

@onready var button = $PartyMemberCard/Button

func _ready():
	button.focus_entered.connect(_on_focus_entered)
	button.pressed.connect(_on_button_pressed)


func _on_focus_entered():
	card_selected.emit(self)

func _on_button_pressed():
	card_activated.emit(self)
