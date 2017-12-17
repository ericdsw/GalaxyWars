extends Node

func _ready():
	pass

func get_max_hp_for_level(level):
	var max_hp = Constants.BATTLESHIP_MAX_HP
	
	for i in range(level - 1):
		max_hp *= Constants.BATTLESHIP_MAX_HP_SCALING
	
	return max_hp

func get_accuracy_for_level(level):
	var accuracy = Constants.BATTLESHIP_BASE_ACCURACY
	
	for i in range(level - 1):
		accuracy += Constants.BATTLESHIP_BASE_ACCURACY_SCALING
	
	return accuracy

func get_evasion_for_level(level):
	var evasion = Constants.BATTLESHIP_BASE_EVASION
	
	for i in range(level - 1):
		evasion += Constants.BATTLESHIP_BASE_EVASION_SCALING
	
	return evasion

func get_base_attack_for_level(level):
	var base_attack = Constants.BATTLESHIP_BASE_ATTACK
	
	for i in range(level - 1):
		base_attack *= Constants.BATTLESHIP_BASE_ATTACK_SCALING

	return base_attack

func get_shield_amount_for_level(level):
	var hp = get_max_hp_for_level(level)
	
	var shield = Constants.SHIELD_COVERAGE
	
	for i in range(level - 1):
		shield += Constants.SHIELD_COVERAGE_PER_LEVEL
	
	return hp * shield

func get_wing_evasion_for_level(level):
	var evasion = Constants.WINGS_BONUS_EVASION
	
	for i in range(level - 1):
		evasion += Constants.WINGS_BONUS_EVASION_PER_LEVEL
	
	return evasion
