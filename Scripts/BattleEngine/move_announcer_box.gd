extends MarginContainer

@onready var move_announcement_label = $MarginContainer/ScrollContainer/MoveAnnouncement

func _ready():
	var newlines = "\n\n"
	var separator = "----------------"

	var intro_message = "Big Bad Evil guys want to do battle" + newlines + separator
	move_announcement_label.set_text(intro_message)


func _process(_delta):
	pass

func make_announcement(move_info, damage_incurred):
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

	# ADDD THE DAMAGE INCURRED STUFF HERE
	var damage_dealt = target.fighter_name + " lost " + str(damage_incurred) + " hp" + newlines

	var success_message = damage_dealt if success else "but it failed... his BP has been exhausted" + newlines

	var new_text = new_message + newlines + success_message + separator + newlines + previous_text

	move_announcement_label.set_text(new_text)

	
