extends VBoxContainer

@onready var party_member_card = preload("res://Scenes/Overworld_UI/PartyBox/party_member_card.tscn")
@onready var party_member_card_container = get_node("PartyCardContainer").get_node("PartyCards")
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
var party_members

func _ready():
	party_members = get_party()
	set_party_cards(party_members)

func set_party_cards(party_list):
	for old_card in party_member_card_container.get_children():
		old_card.queue_free()

	for i in range(len(party_list)):
		var new_member = party_list[i]
		var new_card = party_member_card.instantiate()
		party_member_card_container.add_child(new_card)
		new_card.set_card_info(new_member)
		button_translator[new_card.name] = i
		new_card.card_selected.connect(_on_card_selected)


func get_party():
	var party_member_1 = GovGearson.new()
	var party_member_2 = GovGearson.new()
	var party_member_3 = GovGearson.new()
	party_member_1.set_status("poison", true)
	party_member_1.set_status("mute", true)
	party_member_1.set_status("blind", true)
	return [party_member_1, party_member_2, party_member_3]

func _on_card_selected(card):
	var index = button_translator[card.name]
	var current_party_member = party_members[index]
	set_stats_box(current_party_member)

func activate_box():
	var first_card = party_member_card_container.get_children()[0]
	var button = first_card.button
	button.grab_focus()

func set_stats_box(party_member: PartyMember):
	var stats_dict = party_member.stats_dict
	var abilities_list = party_member.get_abilities_list()
	var magic = party_member.get_magic_list()
	var ring_boosts = party_member.get_ring_boosts()

	stats_container.set_stats(stats_dict)
	ability_container.populate_container(abilities_list)
	magic_container.populate_container(magic)
	ring_boosts_container.populate_container(ring_boosts)


func party_has_focus():
	for card in party_member_card_container.get_children():
		if card.button.has_focus():
			return true
			
	return false
