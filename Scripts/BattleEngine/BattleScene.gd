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
		"attack": 15,
		"defense": 15,
		"magic": 15,
		"magic_defense": 15,
		"speed": 10,
		"luck": 5,
		"vitality": 10,
		"fighter_class": GunnerClass,
		"class_proficiency": 30,
		"max_health": 500,
		"max_boost": 150,
		"boost_per_sec": 2,
		"health_per_sec": 0,
		"weapon_bonus": 10,
		"armor_bonus": 10,
		"inventory": [],
		"snatchable_inventory": ["coins", "coins", "pocket lint", "anal beads"]
	}
	var enemy_member2 = {
		"name": "Big Bad Guy b",
		"texture": texture1,
		"attack": 15,
		"defense": 15,
		"magic": 15,
		"magic_defense": 15,
		"speed": 30,
		"luck": 5,
		"vitality": 10,
		"fighter_class": BlackMageClass,
		"class_proficiency": 30,
		"max_health": 500,
		"max_boost": 30,
		"boost_per_sec": 2,
		"health_per_sec": 0,
		"weapon_bonus": 10,
		"armor_bonus": 10,
		"inventory": ["coins", "coins", "pocket lint", "anal beads"],
		"snatchable_inventory": []
	}

	var enemy_members_data = [enemy_member1, enemy_member2]
	return enemy_members_data

func load_player_data():
	var texture1 = load("res://Sprites/Car_Sprites/Sedan_a.png")
	var player_fighter1 = {
		"name": "Wedge",
		"texture": texture1,
		"attack": 15,
		"defense": 15,
		"magic": 15,
		"magic_defense": 15,
		"speed": 35,
		"luck": 5,
		"vitality": 10,
		"fighter_class": GunnerClass,
		"class_proficiency": 200,
		"max_health": 500,
		"max_boost": 100,
		"boost_per_sec": 2,
		"health_per_sec": 0,
		"weapon_bonus": 10,
		"armor_bonus": 10,
		"inventory": ["coins", "coins", "pocket lint", "anal beads"],
		"snatchable_inventory": ["coins", "coins", "pocket lint", "anal beads"]
	}

	var texture2 = load("res://Sprites/Car_Sprites/FriendCar.png")
	var player_fighter2 = {
		"name": "Wheely",
		"texture": texture2,
		"attack": 15,
		"defense": 15,
		"magic": 15,
		"magic_defense": 15,
		"speed": 20,
		"luck": 5,
		"vitality": 10,
		"fighter_class": ThiefClass,
		"class_proficiency": 30,
		"max_health": 500,
		"max_boost": 100,
		"boost_per_sec": 2,
		"health_per_sec": 0,
		"weapon_bonus": 10,
		"armor_bonus": 10,
		"inventory": ["coins", "coins", "pocket lint", "anal beads"],
		"snatchable_inventory": ["coins", "coins", "pocket lint", "anal beads"]
	}

	var texture3 = load("res://Sprites/Car_Sprites/Sportscar_a.png")
	var player_fighter3 = {
		"name": "Gov. Gearwright",
		"texture": texture3,
		"attack": 15,
		"defense": 15,
		"magic": 15,
		"magic_defense": 15,
		"speed": 30,
		"luck": 5,
		"vitality": 10,
		"fighter_class": MonkClass,
		"class_proficiency": 100,
		"max_health": 500,
		"max_boost": 55,
		"boost_per_sec": 2,
		"health_per_sec": 0,
		"weapon_bonus": 10,
		"armor_bonus": 10,
		"inventory": ["coins", "coins", "pocket lint", "anal beads"],
		"snatchable_inventory": ["coins", "coins", "pocket lint", "anal beads"]
	}
	var texture4 = load("res://Sprites/Car_Sprites/PickupTruck_b.png")
	var player_fighter4 = {
		"name": "Percy",
		"texture": texture4,
		"attack": 15,
		"defense": 15,
		"magic": 15,
		"magic_defense": 15,
		"speed": 50,
		"luck": 5,
		"vitality": 10,
		"fighter_class": DragoonClass,
		"class_proficiency": 100,
		"max_health": 500,
		"max_boost": 55,
		"boost_per_sec": 2,
		"health_per_sec": 0,
		"weapon_bonus": 10,
		"armor_bonus": 10,
		"inventory": ["coins", "coins", "pocket lint", "anal beads"],
		"snatchable_inventory": ["coins", "coins", "pocket lint", "anal beads"]
	}

	var player_fighters_data = [
		player_fighter1,
		player_fighter2,
		player_fighter3,
		player_fighter4
	]
	return player_fighters_data

