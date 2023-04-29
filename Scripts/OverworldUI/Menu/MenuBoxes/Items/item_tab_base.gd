extends MarginContainer

@onready var item_list: ItemList = $ItemList

func populate_list(new_item_list: Array):
	item_list.clear()
	for item in new_item_list:
		item_list.add_item(item.name_string)
