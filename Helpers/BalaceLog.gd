extends Node

func _ready():
	print_stats()
	
	set_process_input(true)

func _input(event):
	if event.is_action_pressed("ui_accept"):
		level_up()

func print_stats():
	var hp = str(Constants.BATTLESHIP_MAX_HP)
	var shield = str(Constants.BATTLESHIP_MAX_HP * Constants.SHIELD_COVERAGE)
	var base_attack = str(Constants.BATTLESHIP_BASE_ATTACK)
	var base_accuracy = str(Constants.BATTLESHIP_BASE_ACCURACY)
	var base_evasion = str(Constants.BATTLESHIP_BASE_EVASION)
	var wings_bonus_evasion = str(Constants.WINGS_BONUS_EVASION)
	
	var bullet_attack = str(Constants.BULLET_DAMAGE)
	var bullet_accuracy = str(Constants.BULLET_ACCURACY)
	var bullet_dmg_to_shield = str(Constants.BULLET_DAMAGE * Constants.MULTIPLIER_BULLET_TO_SHIELD)
	var bullet_dmg_to_ship = str(Constants.BULLET_DAMAGE * Constants.MULTIPLIER_BULLET_TO_SHIP)
	
	var missile_attack = str(Constants.MISSILE_DAMAGE)
	# missile accuracy == 100%
	var missile_dmg_to_shield = str(Constants.MISSILE_DAMAGE * Constants.MULTIPLIER_MISSILE_TO_SHIELD)
	var missile_dmg_to_ship = str(Constants.MISSILE_DAMAGE * Constants.MULTIPLIER_MISSILE_TO_SHIP)
	
	var laser_attack = str(Constants.LASER_DAMAGE)
	var laser_accuracy = str(Constants.LASER_ACCURACY)
	var laser_dmg_to_shield = str(Constants.LASER_DAMAGE * Constants.MULTIPLIER_LASER_TO_SHIELD)
	var laser_dmg_to_ship = str(Constants.LASER_DAMAGE * Constants.MULTIPLIER_LASER_TO_SHIP)
	
	print("HP: ", hp)
	print("Shield Size (HP * " + str(Constants.SHIELD_COVERAGE) + "): " + shield)
	print("Attack: ", base_attack)
	print("Accuracy: ", base_accuracy)
	print("Evasion: ", base_evasion)
	print("Wings Bonus Evasion ", wings_bonus_evasion)
	print("Bullet Attack (Attack * " + str(Constants.BULLET_DAMAGE_MULTIPLIER) + "): " + bullet_attack)
	print("Bullet Accuracy (Accuracy * " + str(Constants.BULLET_ACCURACY_MULTIPLIER) + "): " + bullet_accuracy)
	print("Bullet DMG to Shield (Bullet Attack * " + str(Constants.MULTIPLIER_BULLET_TO_SHIELD) + "): " + bullet_dmg_to_shield)
	print("Bullet DMG to Ship (Bullet Attack * " + str(Constants.MULTIPLIER_BULLET_TO_SHIP) + "): " + bullet_dmg_to_ship)
	print("Missile Attack (Attack * " + str(Constants.MISSILE_DAMAGE_MULTIPLIER) + "): " + missile_attack)
	print("Missile Accuracy: 100%")
	print("Missile DMG to Shield (Missile Attack * " + str(Constants.MULTIPLIER_MISSILE_TO_SHIELD) + "): " + missile_dmg_to_shield)
	print("Missile DMG to Ship (Missile Attack * " + str(Constants.MULTIPLIER_MISSILE_TO_SHIP) + "): " + missile_dmg_to_ship)
	print("Laser Attack (Attack * " + str(Constants.LASER_DAMAGE_MULTIPLIER) + "): " + laser_attack)
	print("Laser Accuracy (Accuracy * " + str(Constants.LASER_ACCURACY_MULTIPLIER) + "): " + laser_accuracy)
	print("Laser DMG to Shield (Laser Attack * " + str(Constants.MULTIPLIER_LASER_TO_SHIELD) + "): " + laser_dmg_to_shield)
	print("Laser DMG to Ship (Laser Attack * " + str(Constants.MULTIPLIER_LASER_TO_SHIP) + "): " + laser_dmg_to_ship)

func level_up():
	print("\nLEVELING UP!")
	print("HP * " + str(Constants.BATTLESHIP_MAX_HP_SCALING))
	print("Shield Coverage + " + str(Constants.SHIELD_COVERAGE_PER_LEVEL))
	print("Attack * " + str(Constants.BATTLESHIP_BASE_ATTACK_SCALING))
	print("Accuracy + " + str(Constants.BATTLESHIP_BASE_ACCURACY_SCALING))
	print("Evasion + " + str(Constants.BATTLESHIP_BASE_EVASION_SCALING))
	print("Wings Bonus Evasion + " +str(Constants.WINGS_BONUS_EVASION_PER_LEVEL))
	
	Constants.level_up()
	print("\nNew Stats")
	print_stats()