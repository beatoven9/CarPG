extends Node

var active_party_members: Array = [GovGearson.new(), Tristan.new()]

var inactive_party_members: Array = [Wedge.new()]

func deactivate_party_member(party_member: PartyMember):
	inactive_party_members.append(party_member)	
	active_party_members.erase(party_member)

func activate_party_member(party_member: PartyMember):
	if len(active_party_members) < 4:
		active_party_members.append(party_member)
		inactive_party_members.erase(party_member)
		return 0
	else:
		return -1

func get_active_party_members():
	return active_party_members

func get_inactive_party_members():
	return inactive_party_members
