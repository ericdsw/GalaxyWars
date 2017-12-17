extends Node2D

onready var menu_items = {
	"missile": {
		"amount": 0,
		"sprite": get_node("MenuItemMissile").get_node("Sprite"),
		"label": get_node("MenuItemMissile").get_node("Label")
	},
	"laser": {
		"amount": 0,
		"sprite": get_node("MenuItemLaser").get_node("Sprite"),
		"label": get_node("MenuItemLaser").get_node("Label")
	},
	"shield": {
		"amount": 0,
		"sprite": get_node("MenuItemShield").get_node("Sprite"),
		"label": get_node("MenuItemShield").get_node("Label")
	},
	"wings": {
		"amount": 0,
		"sprite": get_node("MenuItemWings").get_node("Sprite"),
		"label": get_node("MenuItemWings").get_node("Label")
	}
}

var scrap_menu_order = [ "missile", "laser", "shield", "wings" ] 
var selected_scrap_to_drop = "missile"

func _ready():
	set_fixed_process(true)
	
#func _fixed_process(delta):
#	# Semi-fixes UI bug on player orientation change
#	set_scale(get_parent().get_scale())


func select_previous_scrap():
	var index = _decrement_scrap_index(_get_selected_scrap_index())
	_set_selected_scrap_to_drop(scrap_menu_order[index])
	return scrap_menu_order[index]

func select_next_scrap():
	var index = _increment_scrap_index(_get_selected_scrap_index())
	_set_selected_scrap_to_drop(scrap_menu_order[index])
	return scrap_menu_order[index]

func update_inventory(scrap_inventory):
	for scrap in scrap_inventory.keys():
		menu_items[scrap].amount = scrap_inventory[scrap]

	_update_labels()

func _update_labels():
	for scrap in ["missile", "laser", "shield", "wings"]:
		menu_items[scrap].label.set_text(str(menu_items[scrap].amount))


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
	menu_items[selected_scrap_to_drop].sprite.set("modulate", Color("ffffff"))

func _add_selection_highlight(selected_scrap_to_drop):
	menu_items[selected_scrap_to_drop].sprite.set("modulate", Color(0, 255, 0, 1))
