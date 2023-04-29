extends BaseUnequippable
class_name BaseRestoration

var restoration_amount: int = 0
var unequippable_item_type = UNEQUIPPABLE_TYPES.RESTORATION

func set_restoration_amount(new_amount):
	restoration_amount = new_amount
