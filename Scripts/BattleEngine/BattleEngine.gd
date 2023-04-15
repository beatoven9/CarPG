extends Node2D

@onready var player_fighter = preload("res://Scenes/Battle/player_fighter.tscn")
@onready var enemy = preload("res://Scenes/Battle/enemy_fighter.tscn")
@onready var battle_timer = preload("res://Scenes/Battle/UI/battle_timer.tscn")


var global_fighters_dict = {
	"players": null,
	"enemies": null
}
var move_queue = []

var random = RandomNumberGenerator.new()

@onready var player_party_hud = get_tree().get_root().get_child(0).get_node("CanvasLayer/PlayerPartyHUD")
@onready var enemy_party_hud = get_tree().get_root().get_child(0).get_node("CanvasLayer/EnemyPartyHUD")
@onready var move_announcer_box = get_tree().get_root().get_child(0).get_node("CanvasLayer/MoveAnnouncerBox")

func _ready():
	random.randomize()

func get_living_fighters():

	var living_players = []
	for fighter in global_fighters_dict["players"]:
		if fighter.dead == false:
			living_players.append(fighter)	

	var living_enemies = []
	for fighter in global_fighters_dict["enemies"]:
		if fighter.dead == false:
			living_enemies.append(fighter)	

	var living_fighters_dict = {
		"players": living_players,
		"enemies": living_enemies
	}

	return living_fighters_dict

func start_engine(
	player_fighters_data,
	enemy_members_data,
	items_list
):
	var player_fighters_list = instantiate_player_fighters(player_fighters_data)
	global_fighters_dict["players"] = player_fighters_list

	var enemy_members_list = instantiate_enemy_members(
		enemy_members_data
	)
	global_fighters_dict["enemies"] = enemy_members_list

	for fighter in global_fighters_dict["players"]:
		fighter.fighter_death.connect(_handle_fighter_death)
	for fighter in global_fighters_dict["enemies"]:
		fighter.fighter_death.connect(_handle_fighter_death)
	
	arrange_fighters_on_x_axis(player_fighters_list, enemy_members_list, 256)

	start_play(player_fighters_list, enemy_members_list)


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

	return enemy_members_list

func arrange_fighters_on_x_axis(player_list, enemy_list, available_space):
	var space_segment_size = available_space / 4

	for player_list_member in player_list:
		player_list_member.position.x = -space_segment_size

	for enemy_member in enemy_list:
		enemy_member.position.x = space_segment_size

func start_play(player_fighters, enemy_members):
	update_fighter_huds()

	initiate_atb_meters(player_fighters)
	initiate_atb_meters(enemy_members)

func initiate_atb_meters(
	members_list,
):
	for member in members_list:
		member.ready_to_move.connect(request_move)
		member.move_ready.connect(receive_move_info)
		member.start_battle_timer()

func update_fighter_huds():
	for fighter in global_fighters_dict["players"]:
		fighter.update_hud()

	for fighter in global_fighters_dict["enemies"]:
		fighter.update_hud()


func get_battle_state():
	var battle_state = {
		"player_fighters": global_fighters_dict["players"],
		"enemy_fighters": global_fighters_dict["enemies"]
	}

	return battle_state

func request_move(fighter):
	pause_timers()
	var battle_state = get_battle_state()
	fighter.request_move(battle_state)


func pause_timers():
	for fighter in global_fighters_dict["players"]:
		fighter.pause_timer()

	for fighter in global_fighters_dict["enemies"]:
		fighter.pause_timer()

func resume_timers():
	for fighter in global_fighters_dict["players"]:
		fighter.resume_timer()

	for fighter in global_fighters_dict["enemies"]:
		fighter.resume_timer()

func receive_move_info(move_info):
	move_queue.append(move_info)
	execute_move()

	# resume_timers()


func execute_move():
	if len(move_queue) > 0:
		var move_info = move_queue.pop_at(0)
		apply_move(move_info)

func apply_move(move_info):

	move_info["announcer_box"] = move_announcer_box
	move_info["resume_timers"] = resume_timers
	pause_timers()

	# move_info["success"] = success
	var crit_rolls = []
	for i in range(move_info["user"].fighter_luck):
		var crit_roll = random.randf_range(0, 1)
		crit_rolls.append(crit_roll)

	var success_rolls = []
	for i in range(move_info["user"].fighter_luck):
		var success_roll = random.randf_range(0, 1)
		success_rolls.append(success_roll)

	var highest_crit_roll = crit_rolls.min()
	var highest_success_roll = success_rolls.min()


	var move = move_info["move"]
	var user = move_info["user"]
	var target = move_info["target"]

	move_info = user.use_move(
		move_info,
		highest_success_roll,
		highest_crit_roll,
	)

	if move.steal_item && move_info["success"]:
		move_info["stolen_item"] = barter_steal(user, target)

	move_info = target.receive_move(
		move_info,
	)

	# user.play_attack_animation()
	# This needs to connect the "move_complete" signal to the resume_timers() method on this script
	# Announcement should only play AFTER animation is over.
	# var announcement_string = move_announcer_box.make_announcement(
	# 	move_info,
	# )


	# var announcement_string = move.generate_announcement_string(move_info)
	# move_announcer_box.make_announcement(announcement_string)

	# resume_timers()

func barter_steal(perp, victim):
	if len(victim.snatchable_inventory) > 0:
		var new_item = victim.snatchable_inventory.pick_random()
		var new_item_name = new_item
		perp.inventory.append(new_item)
		return new_item_name
	else:
		return ""


func _handle_fighter_death(fighter):
	check_for_battle_over_state()

func check_for_battle_over_state():
	var living_fighters = get_living_fighters()
	
	if len(living_fighters["players"]) <= 0:
		print("GAME OVER")
	elif len(living_fighters["enemies"]) <= 0:
		print("BATTLE WON!!!")
