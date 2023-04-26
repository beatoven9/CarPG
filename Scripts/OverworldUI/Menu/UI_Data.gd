extends Node2D
class_name UI_Data

var party_member_list # this doubles for use with equipment
var item_list
var quest_list

func set_party_member_list(party_list):
	party_member_list = party_list

func set_item_list(new_list):
	item_list = new_list

func set_quest_list(new_quest_list):
	quest_list = new_quest_list
