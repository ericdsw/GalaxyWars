extends Node2D

export var instance_name = "Station Manager"
export (String) var team_group_name
export var orientation = 1

onready var battleship_scene = load("res://Elements/Battleship.tscn")
onready var missile_launcher_scene = load("res://Elements/PowerUps/MissileLauncher.tscn")
onready var laser_beam_scene = load("res://Elements/PowerUps/LaserBeam.tscn")
onready var shield_scene = load("res://Elements/PowerUps/Shield.tscn")
onready var wings_scene = load("res://Elements/PowerUps/Wings.tscn")

onready var tower = get_node("Tower")

var economy = Constants.STATION_MANAGER_ECONOMY_INITIAL_AMOUNT
var scrap_inventory = {
		"missile": Constants.STATION_MANAGER_MISSILE_INITIAL_AMOUNT,
		"laser": Constants.STATION_MANAGER_LASER_INITIAL_AMOUNT,
		"shield": Constants.STATION_MANAGER_SHIELD_INITIAL_AMOUNT,
		"wings": Constants.STATION_MANAGER_WINGS_INITIAL_AMOUNT
	}

func _ready():
	_print_debug_info()

	TimerGenerator.create_timer(1, "spawn_battleship", self, true).start()

func _on_ship_destroyed():
	TimerGenerator.create_timer(3, "spawn_battleship", self).start()

func spawn_battleship():
	var battleship_instance = battleship_scene.instance()
	battleship_instance.current_level = _get_current_level()

	battleship_instance.orientation = orientation
	battleship_instance.set_pos(get_pos() + Vector2(orientation * 125, -100))
	battleship_instance.set_scale(Vector2(orientation, 1))
	battleship_instance.set_team_group_name(team_group_name)

	_add_power_ups_to_battleship(battleship_instance)

	get_node("/root/Game").add_child(battleship_instance)
	
	battleship_instance.connect("destroyed", self, "_on_ship_destroyed")


func increment_economy(scrap_amount):
	economy += scrap_amount

func increment_power_up(scrap_amount, scrap_type):
	scrap_inventory[scrap_type] = scrap_inventory[scrap_type] + 1
	tower.update_inventory(scrap_inventory)

func _get_current_level():
	return (economy / 10) + 1

func _add_power_ups_to_battleship(battleship):
	if scrap_inventory["missile"] >= Constants.POWER_UP_SCRAP_AMOUNT_FOR_MISSILE: 
		scrap_inventory["missile"] = scrap_inventory["missile"] - Constants.POWER_UP_SCRAP_AMOUNT_FOR_MISSILE
		_add_missile_to_battleship(battleship)

	if scrap_inventory["laser"] >= Constants.POWER_UP_SCRAP_AMOUNT_FOR_LASER: 
		scrap_inventory["laser"] = scrap_inventory["laser"] - Constants.POWER_UP_SCRAP_AMOUNT_FOR_LASER
		_add_laser_to_battleship(battleship)

	if scrap_inventory["shield"] >= Constants.POWER_UP_SCRAP_AMOUNT_FOR_SHIELD: 
		scrap_inventory["shield"] = scrap_inventory["shield"] - Constants.POWER_UP_SCRAP_AMOUNT_FOR_SHIELD
		_add_shield_to_battleship(battleship)

	if scrap_inventory["wings"] >= Constants.POWER_UP_SCRAP_AMOUNT_FOR_WINGS: 
		scrap_inventory["wings"] = scrap_inventory["wings"] - Constants.POWER_UP_SCRAP_AMOUNT_FOR_WINGS
		_add_wings_to_battleship(battleship)

	tower.update_inventory(scrap_inventory)

func _add_missile_to_battleship(battleship):
	var missile_launcher_instance = missile_launcher_scene.instance()
	missile_launcher_instance.orientation = orientation
	missile_launcher_instance.set_pos(battleship.missile_launcher_pos)
	missile_launcher_instance.set_team_group_name(team_group_name)
	# missile_launcher_instance.base_attack = battleship.base_attack
	missile_launcher_instance.base_attack = battleship.get_base_attack_specifically_for_projectile_launcher_hack()
	battleship.add_child(missile_launcher_instance)

func _add_laser_to_battleship(battleship):
	var laser_beam_instance = laser_beam_scene.instance()
	laser_beam_instance.orientation = orientation
	laser_beam_instance.set_pos(battleship.laser_beam_pos)
	laser_beam_instance.set_team_group_name(team_group_name)
	# laser_beam_instance.base_attack = battleship.base_attack
	laser_beam_instance.base_attack = battleship.get_base_attack_specifically_for_projectile_launcher_hack()
	battleship.add_child(laser_beam_instance)

func _add_shield_to_battleship(battleship):
	var shield_instance = shield_scene.instance()
	shield_instance.set_team_group_name(team_group_name)
	battleship.add_child(shield_instance)

func _add_wings_to_battleship(battleship):
	var wings_instance = wings_scene.instance()
	wings_instance.set_pos(battleship.wings_pos)
	battleship.enable_wings_blessing()
	battleship.add_child(wings_instance)

func _print_debug_info():
	print("Station Manager")
	print("instance name: " + instance_name)
	print("team group name: " + team_group_name)
	print("missile: " + str(scrap_inventory["missile"]))
	print("laser: " + str(scrap_inventory["laser"]))
	print("shield: " + str(scrap_inventory["shield"]))
	print("wings: " + str(scrap_inventory["wings"]))
	print("------------------------------------")
