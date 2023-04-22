extends VBoxContainer

@onready var tab_container = $ItemTabs
@onready var all_items_list = $ItemTabs.get_node("All Items").get_node("ItemList")

func activate_box():
	all_items_list.grab_focus()
	all_items_list.select(0)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

