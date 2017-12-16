extends Node2D

# Colors used to draw the health bar
export (Color) var hp_color           = Color(75.00/255.00, 105.00/255.00, 47.00/255.00, 1.00)
export (Color) var damage_color       = Color(172.00/255.00, 50.00/255.00, 50.00/255.00, 1.00)
export (Color) var background_color   = Color(0, 0, 0, 1)

# How fast the red damage bar will decrease
export (int, 1, 10) var drain_speed = 3

# Corners
var initial_corner = Vector2(0, 0)
var final_corner   = Vector2(0, 0)

# Damage Polygons
var current_hp_polygon = Polygon2D.new()
var damage_polygon     = Polygon2D.new()
var background_polygon = Polygon2D.new()

# Provider
var data_provider

# ======================================= Lifecycle ======================================= #

func _ready():
	set_process(true)
	set_fixed_process(true)

	# Adds polygon backgrounds
	add_child(background_polygon)
	add_child(damage_polygon)
	add_child(current_hp_polygon)

	# Configure Polygon Color
	background_polygon.set_color(background_color)
	damage_polygon.set_color(damage_color)
	current_hp_polygon.set_color(hp_color)

	# Performs initial configuration
	_initial_configuration()

func _process(delta):
	if (data_provider != null):
		_calculate_hp_bar_size(data_provider.get_max_hp(), data_provider.get_current_hp())
	else:
		print("data provider is null")
	# Enable fixed process

func _fixed_process(delta):
	var hp_width      = _get_polygon_width(current_hp_polygon)
	var damage_width  = _get_polygon_width(damage_polygon)
	var damage_height = final_corner.y - initial_corner.y
	if hp_width != damage_width:
		if abs(damage_width - hp_width) < drain_speed:
			damage_width = hp_width
		else:
			if final_corner.x > initial_corner.x:
				damage_width -= drain_speed
			else:
				damage_width += drain_speed
		
		_update_polygon(damage_polygon, initial_corner, damage_width, damage_height)

# ======================================= Private Methods ======================================= #

func _initial_configuration():
	var max_width  = final_corner.x - initial_corner.x
	var max_height = final_corner.y - initial_corner.y
	_update_polygon(background_polygon, initial_corner, max_width, max_height)
	_update_polygon(damage_polygon, initial_corner, max_width, max_height)
	_update_polygon(current_hp_polygon, initial_corner, max_width, max_height)

func _update_polygon(polygon, i_corner, width, height):
	polygon.set_polygon([
	    Vector2(i_corner.x, i_corner.y),
	    Vector2(i_corner.x + width, i_corner.y),
	    Vector2(i_corner.x + width, i_corner.y + height),
	    Vector2(i_corner.x, i_corner.y + height)
	])

func _get_polygon_width(polygon):
	var points = polygon.get_polygon()
	var initial_position = points[0]
	var final_position   = points[1]
	return final_position.x - initial_position.x

func _calculate_hp_bar_size(max_hp, current_hp):
	var max_hp_bar_width     = final_corner.x - initial_corner.x
	var hp_bar_height        = final_corner.y - initial_corner.y
	var current_hp_bar_width = (float(current_hp) / float(max_hp) * max_hp_bar_width) if max_hp > 0 else 0
	
	_update_polygon(current_hp_polygon, initial_corner, current_hp_bar_width, hp_bar_height)

