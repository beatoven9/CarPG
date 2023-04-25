extends MarginContainer

@onready var ability_column = preload("res://Scenes/Overworld_UI/PartyStats/ability_column.tscn")
@onready var ability_columns = $MarginContainer/CharacterAbilityContainer/AbilitiesColumns


func clear_container():
	for child in ability_columns.get_children():
		child.queue_free()

func populate_container(abilities):
	# var column_num = ceil(len(abilities) / 8)
	clear_container()

	var counter = 0
	var slices = [[]]
	var current_slice_counter = 0

	for i in range(len(abilities)):
		if (counter % 8) == 0:
			slices.append([])
			current_slice_counter += 1

		slices[current_slice_counter].append(abilities[i])
		counter += 1

	for slice in slices:
		var new_column = ability_column.instantiate()
		ability_columns.add_child(new_column)
		new_column.create_column(slice)
