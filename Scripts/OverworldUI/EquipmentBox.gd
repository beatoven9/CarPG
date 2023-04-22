extends MarginContainer

@onready var party_members = $VBoxContainer/PartyMemberContainer.get_children()
@onready var first_slot = party_members[0].weapon_slot


func activate_box():
	var first_button = first_slot.get_node("VBoxContainer").get_node("MarginContainer").get_node("Button")
	first_button.grab_focus()

func get_equipment_textures():
	for party_member in party_members:
		for slot in party_member.equipment_slots:
			pass
