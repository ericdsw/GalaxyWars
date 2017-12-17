extends '../General/HpBar.gd'

# Shield Color
export (Color) var shield_color = Color(94.00/255.00, 121.00/255.00, 255.00/255.00, 1.00)

# Shield polygons
var max_shield_polygon     = Polygon2D.new()
var current_shield_polygon = Polygon2D.new()

# Shield drawing corners
var initial_shield_corner = Vector2(0, 0)
var final_shield_corner   = Vector2(0, 0)

# Data provider for shield
var shield_provider
var show_on_empty = false

func _process(delta):
	if (shield_provider != null):
		_calculate_shield_size(shield_provider.get_max_shield(), shield_provider.get_current_shield())
		if shield_provider.get_current_shield() <= 0 && has_node("ShieldOutline") && !show_on_empty:
			remove_child(get_node("ShieldOutline"))
			remove_child(max_shield_polygon)
			remove_child(current_shield_polygon)
	else:
		if has_node("ShieldOutline") && !show_on_empty:
			remove_child(max_shield_polygon)
			remove_child(current_shield_polygon)
			remove_child(get_node("ShieldOutline"))

func _initial_configuration():

	initial_corner        = get_node("HpOutline/InitialCorner").get_pos()
	final_corner          = get_node("HpOutline/FinalCorner").get_pos()
	initial_shield_corner = get_node("ShieldOutline/InitialCorner").get_pos()
	final_shield_corner   = get_node("ShieldOutline/FinalCorner").get_pos()

	add_child(max_shield_polygon)
	add_child(current_shield_polygon)

	max_shield_polygon.set_pos(get_node("ShieldOutline").get_pos())
	current_shield_polygon.set_pos(get_node("ShieldOutline").get_pos())

	max_shield_polygon.set_color(background_color)
	current_shield_polygon.set_color(shield_color)

	var max_shield_width  = final_shield_corner.x - initial_shield_corner.x
	var max_shield_height = final_shield_corner.y - initial_shield_corner.y

	_update_polygon(max_shield_polygon, initial_shield_corner, max_shield_width, max_shield_height)
	_update_polygon(current_shield_polygon, initial_shield_corner, max_shield_width, max_shield_height)

	._initial_configuration()

func _calculate_shield_size(max_shield, current_shield):
	var max_shield_bar_width     = final_shield_corner.x - initial_shield_corner.x
	var shield_bar_height        = final_shield_corner.y - initial_shield_corner.y
	var current_shield_bar_width = float(current_shield) / float(max_shield) * max_shield_bar_width
	
	_update_polygon(current_shield_polygon, initial_shield_corner, current_shield_bar_width, shield_bar_height)
