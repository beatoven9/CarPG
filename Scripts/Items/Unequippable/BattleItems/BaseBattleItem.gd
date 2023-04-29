extends BaseUnequippable
class_name BaseBattleItem

var unequippable_item_type = UNEQUIPPABLE_TYPES.BATTLE_ITEM
var damage_amount: int = 0

func set_damage_amount(new_amount: int):
	damage_amount = new_amount
