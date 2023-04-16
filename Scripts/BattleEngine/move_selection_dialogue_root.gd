extends MarginContainer

signal move_complete(move, target)

@onready var fighter_name_label = $VBoxContainer/FighterNameMargin/FighterNameLabel

@onready var entry_box = $VBoxContainer/MarginContainer/Entry
@onready var magic_box = $VBoxContainer/MarginContainer/Magic
@onready var abilities_box = $VBoxContainer/MarginContainer/Abilities
@onready var items_box = $VBoxContainer/MarginContainer/Items
@onready var flex_box = $VBoxContainer/MarginContainer/Flex
@onready var enemy_target_box = $VBoxContainer/MarginContainer/EnemyTargets
@onready var player_target_box = $VBoxContainer/MarginContainer/PlayerTargets
@onready var target_box = $VBoxContainer/MarginContainer/Targets

@onready var boxes_list = [
	entry_box,
	magic_box,
	abilities_box,
	items_box,
	flex_box,
	enemy_target_box,
	player_target_box,
	target_box
]

# @onready var current_box = entry_box
var box_stack = []

var friendly_target_list = []
var enemy_target_list = []

var target_list = []

var move_list = []
var current_battle_state
var selected_move
var previously_selected_target = null
var available_moves

var magic_spells: Array
var abilities: Array
var items: Array
var flex_options: Array


func _ready():
	entry_box.item_activated.connect(_on_entry_level_selection)

	target_box.item_activated.connect(_on_target_selected)
	target_box.item_selected.connect(_on_target_selection_changed)

	magic_box.item_activated.connect(_on_magic_selected)
	abilities_box.item_activated.connect(_on_ability_selected)
	items_box.item_activated.connect(_on_item_selected)
	flex_box.item_activated.connect(_on_flex_option_selected)


func close_all_boxes():
	for box in boxes_list:
		box.set_visible(false)
		box.release_focus()

func _input(_event):
	if Input.is_action_just_pressed("ui_left"):
		ui_back(box_stack)


func ui_back(current_box_stack):
	if len(box_stack) > 0:
		var current_box = current_box_stack.pop_back()
		if current_box.has_focus():
			if current_box == entry_box:
				box_stack = [entry_box]
			else:
				var previous_box = box_stack.pop_back()
				box_stack.append(previous_box)

				close_all_boxes()

				if is_instance_valid(previously_selected_target):
					previously_selected_target.get_unselected()

				previous_box.set_visible(true)
				previous_box.grab_focus.call_deferred()

		else:
			pass

func prompt_for_move(fighter, new_available_moves, new_battle_state):
	box_stack.push_back(entry_box)

	fighter_name_label.set_text(" " + fighter.fighter_name)

	available_moves = new_available_moves

	entry_box.set_item_text(0, " " + available_moves.attack.move_name)
	current_battle_state = new_battle_state

	magic_spells = available_moves.magic
	abilities = available_moves.abilities
	items = available_moves.items

	if len(available_moves.flex_options) > 0:
		flex_options = available_moves.flex
		var flex_name = available_moves.flex_name
		if entry_box.get_item_at_position(4) != -1:
			entry_box.remove_item(4)

		entry_box.add_item(flex_name)
	else:
		flex_options = []

	set_visible(true)
	entry_box.grab_focus()
	entry_box.select(0)
	entry_box.set_visible(true)

func _on_entry_level_selection(idx):
	if idx == 0:
		selected_move = available_moves.attack
		prompt_for_target()
	elif idx == 1:
		prompt_for_magic(magic_spells)
	elif idx == 2:
		prompt_for_ability(abilities)
	elif idx == 3:
		prompt_for_item(items)
	elif idx == 4:
		prompt_for_flex(flex_options)


func prompt_for_magic(spells):
	magic_box.clear()

	if len(spells) > 0:
		box_stack.push_back(magic_box)
		for spell in spells:
			magic_box.add_item(spell.move_name)

		close_all_boxes()

		magic_box.grab_focus()
		magic_box.select(0)
		magic_box.set_visible(true)
	else:
		# play a noise and briefly change the color of something to red
		print("NO MAGIC")

func _on_magic_selected(magic_idx):
	selected_move = magic_spells[magic_idx]
	prompt_for_target()	


func prompt_for_ability(abilities_list):
	abilities_box.clear()
	
	if len(abilities_list) > 0:
		box_stack.push_back(abilities_box)

		for ability in abilities_list:
			abilities_box.add_item(ability.move_name)

		close_all_boxes()

		abilities_box.grab_focus()
		abilities_box.select(0)
		abilities_box.set_visible(true)

	else:
		print("No abilities")

func _on_ability_selected(ability_idx):
	selected_move = abilities[ability_idx]
	prompt_for_target()	


func prompt_for_item(items_list):
	items_box.clear()

	if len(items_list) > 0:
		box_stack.push_back(items_box)
		
		for item in items_list:
			items_box.add_item(item.item_name)

		close_all_boxes()

		items_box.grab_focus()
		items_box.select(0)
		items_box.set_visible(true)

	else:
		print("No items")

func _on_item_selected(item_idx):
	selected_move = items[item_idx]
	prompt_for_target()	


func prompt_for_flex(flex_options_list):
	box_stack.push_back(flex_box)
	flex_box.clear()

	for flex_option in flex_options_list:
		flex_box.add_item(flex_option.move_name)

	close_all_boxes()

	flex_box.grab_focus()
	flex_box.select(0)
	flex_box.set_visible(true)
	
func _on_flex_option_selected(flex_option_idx):
	selected_move = items[flex_option_idx]
	prompt_for_target()	

func prompt_for_target():
	box_stack.push_back(target_box)
	close_all_boxes()

	# enemy_target_box.clear()
	target_box.clear()

	target_list = []

	if selected_move.friendly == true:
		for player in current_battle_state["player_fighters"]:
			target_list.append(player)
			target_box.add_item(player.fighter_name)

		for enemy in current_battle_state["enemy_fighters"]:
			target_list.append(enemy)
			target_box.add_item(enemy.fighter_name)
	elif selected_move.friendly == false:
		for enemy in current_battle_state["enemy_fighters"]:
			if enemy.dead == false:
				target_list.append(enemy)
				target_box.add_item(enemy.fighter_name)

		for player in current_battle_state["player_fighters"]:
			if player.dead == false:
				target_list.append(player)
				target_box.add_item(player.fighter_name)

	target_box.grab_focus()
	target_box.select(0)
	target_box.item_selected.emit(0)
	target_box.set_visible(true)
	
func _on_target_selected(target_idx):
	var selected_target = target_list[target_idx]
	move_complete.emit(selected_move, selected_target)
	selected_target.get_unselected()
	close_all_boxes()
	set_visible(false)

func _on_target_selection_changed(target_index):

	if is_instance_valid(previously_selected_target):
		previously_selected_target.get_unselected()

	var target = target_list[target_index]
	target.get_selected()
	previously_selected_target = target
