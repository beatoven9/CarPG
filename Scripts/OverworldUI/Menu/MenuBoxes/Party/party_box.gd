extends VBoxContainer

@onready var party_member_cards = get_node("PartyCardContainer").get_node("PartyCards").get_children()
@onready var character_info_container = $CharacterInfo/HBoxContainer/MarginContainer/CharacterInfoContainer
@onready var stats_container = character_info_container.get_node("CharacterStatsContainer")
@onready var ability_container = character_info_container.get_node("CharacterAbilityContainer")
@onready var magic_container = character_info_container.get_node("CharacterMagicContainer")
@onready var ring_boosts_container = character_info_container.get_node("CharacterRingBoostsContainer")

signal go_back

func _input(event):
	if party_has_focus():
		if event.is_action_pressed("ui_cancel"):
			go_back.emit()
			accept_event()


var button_translator = {}
var party_mem_dicts

func _ready():
	for i in range(len(party_member_cards)):
		button_translator[party_member_cards[i].name] = i
		party_member_cards[i].card_selected.connect(_on_card_selected)

	# This part should be set way earlier.
	# Probably by the menu everytime it's toggled on it will poll for the
	# party singleton's state
	var party_mem_dict = {
		"stats_dict": {
			"attack": 90,
			"defense": 100,
			"magic": 50,
			"magic_defense": 90,
			"speed": 100
		},
		"abilities": ["Jump", "Jump-high", "Swipe"],
		"magic": ["Fire", "Frost", "Flood", "Shock"],
		"ring_boosts": ["Fire-boost 1", "Shock-boost 2"],
	}

	var party_mem_dict1 = {
		"stats_dict": {
			"attack": 100,
			"defense": 95,
			"magic": 150,
			"magic_defense": 200,
			"speed": 50
		},
		"abilities": ["Jump", "Jump-high", "Swipe", "Jinkies"],
		"magic": ["Fire", "Frost", "Flood", "Shock", "Shock 2", "Shock 3"],
		"ring_boosts": ["Fire-boost 1", "Shock-boost 2", "Flood-boost 4"],
	}

	party_mem_dicts = [party_mem_dict, party_mem_dict1, party_mem_dict, party_mem_dict1]

func set_party_mem_dicts(dict_list):
	party_mem_dicts = dict_list


func _on_card_selected(card):
	var index = button_translator[card.name]
	var current_dict = party_mem_dicts[index]
	set_stats_box(current_dict)

func activate_box():
	var party_member_card = party_member_cards[0]
	var button = party_member_card.button
	button.grab_focus()

func set_stats_box(party_member):
	var stats_dict = party_member["stats_dict"]
	var abilities_list = party_member["abilities"]
	var magic = party_member["magic"]
	var ring_boosts = party_member["ring_boosts"]

	stats_container.set_stats(stats_dict)
	ability_container.populate_container(abilities_list)
	magic_container.populate_container(magic)
	ring_boosts_container.populate_container(ring_boosts)


func party_has_focus():
	for card in party_member_cards:
		if card.button.has_focus():
			return true
			
	return false
