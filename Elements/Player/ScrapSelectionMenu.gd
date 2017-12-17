extends Node2D


onready var menu_items = {
	"missile": {
		"amount": 0,
		"node": get_node("MenuItemMissile").get_node("Sprite")
	},
	"laser": {
		"amount": 0,
		"node": get_node("MenuItemLaser").get_node("Sprite")
	},
	"shield": {
		"amount": 0,
		"node": get_node("MenuItemShield").get_node("Sprite")
	},
	"wings": {
		"amount": 0,
		"node": get_node("MenuItemWings").get_node("Sprite")
	}
}

var scrap_menu_order = [ "missile", "laser", "shield", "wings" ] 
var selected_scrap_to_drop = "missile"

func select_previous_scrap():
	var index = _decrement_scrap_index(_get_selected_scrap_index())

	_set_selected_scrap_to_drop(scrap_menu_order[index])

func select_next_scrap():
	var index = _increment_scrap_index(_get_selected_scrap_index())

	_set_selected_scrap_to_drop(scrap_menu_order[index])

func _get_selected_scrap_index():
	var index = scrap_menu_order.find(selected_scrap_to_drop)

	if index == -1:
		print("Error: scrap item not found on menu")
		return 0

	return index

func _increment_scrap_index(index):
	index = index + 1;

	if index > 3: 
		index = 3

	return index

func _decrement_scrap_index(index):
	index = index - 1;

	if index < 0: 
		index = 0

	return index

func _set_selected_scrap_to_drop(selected_scrap_to_drop):
	var current_selected_scrap_to_drop = self.selected_scrap_to_drop

	_remove_selection_highlight(current_selected_scrap_to_drop)
	_add_selection_highlight(selected_scrap_to_drop)

	self.selected_scrap_to_drop = selected_scrap_to_drop


func _remove_selection_highlight(selected_scrap_to_drop):
	print("remove to: ", selected_scrap_to_drop)
	print("node: ", menu_items[selected_scrap_to_drop].node)
	menu_items[selected_scrap_to_drop].node.set("modulate", Color("ffffff"))

func _add_selection_highlight(selected_scrap_to_drop):
	print("add to: ", selected_scrap_to_drop)
	menu_items[selected_scrap_to_drop].node.set("modulate", Color("000000"))
