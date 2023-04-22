extends VBoxContainer

@onready var party_members = get_children()

func activate_box():
	var party_member = party_members[0]
	var button = party_member.get_node("PartyMemberCard").get_node("Button")
	button.grab_focus()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
