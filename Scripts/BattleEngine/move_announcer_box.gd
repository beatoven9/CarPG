extends MarginContainer

@onready var move_announcement_label = $MarginContainer/ScrollContainer/MoveAnnouncement

func _ready():
	pass # Replace with function body.


func _process(delta):
	pass

func make_announcement(move_info):
	var move = move_info["move"]
	var user = move_info["user"]
	var target = move_info["target"]
	var success = move_info["success"]

	# var critical = move_info["critical"]



	# This needs to be animated somehow. it's way too jarring
	# one possible fix to this is to make the container actually
	# a stack of labels inside a scrolling container.
	# This way we just dynamically add a new label for each new move.
	# This way, we might have access to some built in animation methods.
	var newlines = "\n\n"
	var separator = "----------------"
	var previous_text = move_announcement_label.get_text()
	var new_message = user.fighter_name + " did " + move.move_name + " against " + target.fighter_name

	var new_text = new_message + newlines + separator + newlines + previous_text

	move_announcement_label.set_text(new_text)

	
