extends Node2D

@onready var party_member = preload("res://Scenes/Battle/party_member.tscn")
@onready var enemy = preload("res://Scenes/Battle/enemy_fighter.tscn")
@onready var battle_timer = preload("res://Scenes/Battle/battle_timer.tscn")

var global_member_timers = []
var global_enemy_timers = []
var move_queue = []

# @onready var camera = get_tree().get_root().get_child(0).get_node("Camera2D")
@onready var atb_meter = get_tree().get_root().get_child(0).get_node("CanvasLayer/ATB_Meter")

func load_enemy_data():
	var texture1 = load("res://Sprites/PickupTruck_b.png")
	var enemy_member1 = {
		"name": "enemy_1",
		"texture": texture1,
		"speed": 90
	}

	var enemy_members_data = [enemy_member1]
	return enemy_members_data

func load_player_data():
	var texture1 = load("res://Sprites/Sedan_a.png")
	var party_member1 = {
		"name": "player_1",
		"texture": texture1,
		"speed": 20
	}

	var texture2 = load("res://Sprites/FriendCar.png")
	var party_member2 = {
		"name": "friend_car",
		"texture": texture2,
		"speed": 50
	}

	var texture3 = load("res://Sprites/Sportscar_a.png")
	var party_member3 = {
		"name": "sportscar",
		"texture": texture3,
		"speed": 120
	}

	var party_members_data = [
		party_member1,
		party_member2,
		party_member3
	]
	return party_members_data

func arrange_fighters_on_y_axis(
	fighter_list: Array,
	y_range, 
	y_offset
):
	var space_between = y_range / len(fighter_list)
	var current_pos = y_offset
	for fighter in fighter_list:
		fighter.position.y = current_pos
		current_pos += space_between

func instantiate_party_members(party_members_data):
	var party_members_list = []
	for member_data in party_members_data:
		var new_party_member = party_member.instantiate()
		new_party_member.set_data(
			member_data["name"],
			member_data["texture"],
			member_data["speed"]
		)
		add_child(new_party_member)
		party_members_list.append(new_party_member)
	arrange_fighters_on_y_axis(party_members_list, 96, 0)

	return party_members_list

func instantiate_enemy_members(enemy_members_data):
	var enemy_members_list = []
	for member_data in enemy_members_data:
		var new_enemy_member = enemy.instantiate()
		new_enemy_member.set_data(
			member_data["name"],
			member_data["texture"],
			member_data["speed"],
		)
		add_child(new_enemy_member)
		enemy_members_list.append(new_enemy_member)
	arrange_fighters_on_y_axis(enemy_members_list, 96, 0)

	return enemy_members_list

func arrange_fighters_on_x_axis(party_list, enemy_list, available_space):
	var space_segment_size = available_space / 4

	for party_list_member in party_list:
		party_list_member.position.x = -space_segment_size

	for enemy_member in enemy_list:
		enemy_member.position.x = space_segment_size

func start_play(party_members, enemy_members):
	var party_timers = initiate_atb_meters(party_members)
	var enemy_timers = initiate_atb_meters(enemy_members)

	print(party_timers, enemy_timers)

func initiate_atb_meters(
	members_list,
):
	var timer_list = []

	for member in members_list:
		var timer = battle_timer.instantiate()
		member.add_child(timer)
		timer_list.append(timer)
		timer.battle_timer_out.connect(request_move)

	return timer_list

func request_move(fighter):
	pause_timers()
	fighter.request_move()
	print("MOVE ", fighter)

func pause_timers():
	for timer in global_member_timers:
		timer.set_paused(true)
	for timer in global_enemy_timers:
		timer.set_paused(true)

func resume_timers():
	for timer in global_member_timers:
		timer.set_paused(false)
	for timer in global_enemy_timers:
		timer.set_paused(false)

func receive_move(move_info):
	move_queue.append(move_info)
	execute_move()

	resume_timers()


func execute_move():
	if len(move_queue) > 0:
		var move_info = move_queue.pop_at(0)
		apply_move(move_info)

func apply_move(move_info):
	var move = move_info["move"]
	var user = move_info["user"]
	var target = move_info["target"]

	# user.play_attack_animation()
	#
	# THIS IS WHERE I LEFT OFF ^^^

	pause_timers()
	
	# This needs to connect the "move_complete" signal to the resume_timers() method on this script


func _ready():

	var party_members_data = load_player_data()
	var party_members_list = instantiate_party_members(party_members_data)

	var enemy_members_data = load_enemy_data()
	var enemy_members_list = instantiate_enemy_members(
		enemy_members_data
	)

	arrange_fighters_on_x_axis(party_members_list, enemy_members_list, 256)

	start_play(party_members_list, enemy_members_list)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
