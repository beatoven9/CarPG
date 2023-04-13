extends MarginContainer

@onready var move_announcement_label = $MarginContainer/ScrollContainer/MoveAnnouncement

func _ready():
	var newlines = "\n\n"
	var separator = "----------------"

	var intro_message = "Big Bad Evil guys want to do battle" + newlines + separator
	move_announcement_label.set_text(intro_message)


func _process(_delta):
	pass

func make_announcement(move_info, damage_incurred, item_stolen):
	var move = move_info["move"]
	var user = move_info["user"]
	var target = move_info["target"]

	# var critical = move_info["critical"]


	var new_announcement = generate_announcement(
		move,
		user,
		target,
		damage_incurred,
		item_stolen
	)
	# This needs to be animated somehow. it's way too jarring
	# one possible fix to this is to make the container actually
	# a stack of labels inside a scrolling container.
	# This way we just dynamically add a new label for each new move.
	# This way, we might have access to some built in animation methods.
	var newlines = "\n\n\n"
	var separator = "----------------"
	var previous_text = move_announcement_label.get_text()

	var new_text = new_announcement + newlines + separator + newlines + previous_text

	move_announcement_label.set_text(new_text)

	
func generate_announcement(
	move,
	user,
	target,
	damage_incurred,
	item_stolen
):
	var attack_announcement = user.fighter_name + " performed " + move.move_name +  " against " + target.fighter_name + "."
	
	var defense_announcement
	if damage_incurred > 0:
		defense_announcement = target.fighter_name + " received " + str(damage_incurred) + " damage."
	else:
		defense_announcement = "but it failed!..."

	var steal_announcement
	if item_stolen != "Nothing":
		steal_announcement = str(item_stolen) + " was stolen!"
	else:
		steal_announcement = ""

	var newline = "\n\n"

	var announcement = attack_announcement + newline + defense_announcement + newline + steal_announcement

	return announcement
