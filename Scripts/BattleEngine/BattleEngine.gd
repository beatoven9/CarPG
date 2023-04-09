extends Node2D

@onready var player_fighter = preload("res://Scenes/Battle/player_fighter.tscn")
@onready var enemy = preload("res://Scenes/Battle/enemy_fighter.tscn")
@onready var battle_timer = preload("res://Scenes/Battle/UI/battle_timer.tscn")
@onready var move_selection_box = preload("res://Scenes/Battle/UI/move_selection_dialogue.tscn")


var global_fighters_list = []
var global_player_fighters = []
var global_enemy_fighters = []
var move_queue = []

@onready var player_party_hud = get_tree().get_root().get_child(0).get_node("CanvasLayer/PlayerPartyHUD")
@onready var enemy_party_hud = get_tree().get_root().get_child(0).get_node("CanvasLayer/EnemyPartyHUD")


func load_enemy_data():
	var texture1 = load("res://Sprites/Car_Sprites/PickupTruck_b.png")
	var enemy_member1 = {
		"name": "Big Bad Guy b",
		"texture": texture1,
		"speed": 10,
		"fighter_class": GunnerClass,
		"class_proficiency": 30
	}
	var enemy_member2 = {
		"name": "Big Bad Guy a",
		"texture": texture1,
		"speed": 10,
		"fighter_class": GunnerClass,
		"class_proficiency": 30
	}

	var enemy_members_data = [enemy_member1, enemy_member2]
	return enemy_members_data

func load_player_data():
	var texture1 = load("res://Sprites/Car_Sprites/Sedan_a.png")
	var player_fighter1 = {
		"name": "Rusty",
		"texture": texture1,
		"speed": 20,
		"fighter_class": GunnerClass,
		"class_proficiency": 30
	}

	var texture2 = load("res://Sprites/Car_Sprites/FriendCar.png")
	var player_fighter2 = {
		"name": "Wheely",
		"texture": texture2,
		"speed": 12,
		"fighter_class": GunnerClass,
		"class_proficiency": 30,
	}

	var texture3 = load("res://Sprites/Car_Sprites/Sportscar_a.png")
	var player_fighter3 = {
		"name": "Gov. Gearwright",
		"texture": texture3,
		"speed": 16,
		"fighter_class": GunnerClass,
		"class_proficiency": 30,
	}

	var player_fighters_data = [
		player_fighter1,
		player_fighter2,
		player_fighter3
	]
	return player_fighters_data

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

func instantiate_player_fighters(player_fighters_data):
	var player_fighters_list = []
	for member_data in player_fighters_data:
		var new_player_fighter = player_fighter.instantiate()
		new_player_fighter.set_data(
			member_data
		)

		add_child(new_player_fighter)
		player_fighters_list.append(new_player_fighter)
	arrange_fighters_on_y_axis(player_fighters_list, 96, 0)
	player_party_hud.create_party(player_fighters_list)

	return player_fighters_list

func instantiate_enemy_members(enemy_members_data):
	var enemy_members_list = []
	for member_data in enemy_members_data:
		var new_enemy_member = enemy.instantiate()
		new_enemy_member.set_data(
			member_data
		)
		add_child(new_enemy_member)
		enemy_members_list.append(new_enemy_member)
	arrange_fighters_on_y_axis(enemy_members_list, 96, 0)
	enemy_party_hud.create_party(enemy_members_list)

	return enemy_members_list

func arrange_fighters_on_x_axis(player_list, enemy_list, available_space):
	var space_segment_size = available_space / 4

	for player_list_member in player_list:
		player_list_member.position.x = -space_segment_size

	for enemy_member in enemy_list:
		enemy_member.position.x = space_segment_size

func start_play(player_fighters, enemy_members):
	global_fighters_list = player_fighters + enemy_members

	initiate_atb_meters(player_fighters)
	initiate_atb_meters(enemy_members)

func initiate_atb_meters(
	members_list,
):
	for member in members_list:
		member.ready_to_move.connect(request_move)
		member.move_ready.connect(receive_move_info)
		member.start_battle_timer()

func get_battle_state():
	var battle_state = {
		"player_fighters": global_player_fighters,
		"enemy_fighters": global_enemy_fighters
	}

	return battle_state

func request_move(fighter):
	pause_timers()
	var battle_state = get_battle_state()
	fighter.request_move(battle_state)


func pause_timers():
	for fighter in global_fighters_list:
		fighter.pause_timer()

func resume_timers():
	for fighter in global_fighters_list:
		fighter.resume_timer()

func receive_move_info(move_info):
	move_queue.append(move_info)
	execute_move()

	resume_timers()


func execute_move():
	if len(move_queue) > 0:
		var move_info = move_queue.pop_at(0)
		apply_move(move_info)

func apply_move(move_info):
	pause_timers()

	var move = move_info["move"]
	var user = move_info["user"]
	var target = move_info["target"]


	target.handle_move_receipt(move)

	resume_timers()
	# user.play_attack_animation()
	#
	# THIS IS WHERE I LEFT OFF ^^^

		
	# This needs to connect the "move_complete" signal to the resume_timers() method on this script


func _ready():

	var player_fighters_data = load_player_data()
	var player_fighters_list = instantiate_player_fighters(player_fighters_data)
	global_player_fighters = player_fighters_list

	var enemy_members_data = load_enemy_data()
	var enemy_members_list = instantiate_enemy_members(
		enemy_members_data
	)
	global_enemy_fighters = enemy_members_list

	arrange_fighters_on_x_axis(player_fighters_list, enemy_members_list, 256)

	start_play(player_fighters_list, enemy_members_list)

func _process(_delta):
	pass
