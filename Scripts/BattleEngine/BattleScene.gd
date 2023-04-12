extends Node2D

@onready var battle_engine = $BattleEngine

func _ready():
	var enemy_data = load_enemy_data()
	var player_data = load_player_data()
	var items_list = []
	battle_engine.start_engine(
		player_data,
		enemy_data,
		items_list
	)


func load_enemy_data():
	var texture1 = load("res://Sprites/Car_Sprites/PickupTruck_b.png")
	var enemy_member1 = {
		"name": "Big Bad Guy a",
		"texture": texture1,
		"speed": 10,
		"fighter_class": GunnerClass,
		"class_proficiency": 30,
		"max_health": 20,
		"max_boost": 50,
		"boost_per_sec": 2,
		"health_per_sec": 0,
	}
	var enemy_member2 = {
		"name": "Big Bad Guy b",
		"texture": texture1,
		"speed": 10,
		"fighter_class": GunnerClass,
		"class_proficiency": 30,
		"max_health": 20,
		"max_boost": 30,
		"boost_per_sec": 2,
		"health_per_sec": 0,
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
		"class_proficiency": 30,
		"max_health": 5,
		"max_boost": 50,
		"boost_per_sec": 2,
		"health_per_sec": 0,
	}

	var texture2 = load("res://Sprites/Car_Sprites/FriendCar.png")
	var player_fighter2 = {
		"name": "Wheely",
		"texture": texture2,
		"speed": 12,
		"fighter_class": BlackMageClass,
		"class_proficiency": 30,
		"max_health": 5,
		"max_boost": 70,
		"boost_per_sec": 2,
		"health_per_sec": 0,
	}

	var texture3 = load("res://Sprites/Car_Sprites/Sportscar_a.png")
	var player_fighter3 = {
		"name": "Gov. Gearwright",
		"texture": texture3,
		"speed": 16,
		"fighter_class": GunnerClass,
		"class_proficiency": 30,
		"max_health": 5,
		"max_boost": 55,
		"boost_per_sec": 2,
		"health_per_sec": 0,
	}

	var player_fighters_data = [
		player_fighter1,
		player_fighter2,
		player_fighter3
	]
	return player_fighters_data

