extends Node

const BULLET_DAMAGE = 10
const BULLET_SPEED = 800
const BULLET_FIRE_RATE = 0.25
const BULLET_FIRE_RATE_VARIANCE = 0.10
const BULLET_DAMAGE_MULTIPLIER = 0.5
const BULLET_ACCURACY_MULTIPLIER = 0.8
const BULLET_SPEED = 800
const BULLET_FIRE_RATE = 0.25
const BULLET_FIRE_RATE_VARIANCE = 0.10

const PLAYER_BULLET_SPEED = 600
const PLAYER_FIRE_RATE = 2
const PLAYER_SHOCKED_TIME = 1 
const PLAYER_MOVEMENT_SPEED = 400
const PLAYER_JUMP_FORCE = 600
const PLAYER_SCRAP_MENU_TIME_UNTIL_HIDE = 3

const GRAVITY = Vector2(0, 1000)
const FRICTION = 20

const STATION_SHIP_COOLDOWN = 5
const STATION_MANAGER_ECONOMY_INITIAL_AMOUNT = 0
const STATION_MANAGER_ECONOMY_AMOUNT_TO_LEVEL_UP = 25
const STATION_MANAGER_MISSILE_INITIAL_AMOUNT = 8
const STATION_MANAGER_LASER_INITIAL_AMOUNT = 8
const STATION_MANAGER_SHIELD_INITIAL_AMOUNT = 8
const STATION_MANAGER_WINGS_INITIAL_AMOUNT = 8

const BONUS_SCRAP_DROP_QUANTITY = 2

const PLAYER_SCRAP_DEFAULT_DEPOSIT_AMOUNT = 1
const PLAYER_MISSILE_INITIAL_AMOUNT = 0
const PLAYER_LASER_INITIAL_AMOUNT = 0
const PLAYER_SHIELD_INITIAL_AMOUNT = 0
const PLAYER_WINGS_INITIAL_AMOUNT = 0

const POWER_UP_SCRAP_AMOUNT_FOR_MISSILE = 4
const POWER_UP_SCRAP_AMOUNT_FOR_LASER = 4
const POWER_UP_SCRAP_AMOUNT_FOR_SHIELD = 4
const POWER_UP_SCRAP_AMOUNT_FOR_WINGS = 4

# Base stats for battleship
var BATTLESHIP_MAX_HP = 400
var BATTLESHIP_BASE_ATTACK = 20
const BATTLESHIP_INITIAL_LEVEL = 1
const BATTLESHIP_BASE_ACCURACY = 100
const BATTLESHIP_BASE_EVASION = 5

# HP and attack scale by a factor of <x> per level
const BATTLESHIP_MAX_HP_SCALING = 1.2
const BATTLESHIP_BASE_ATTACK_SCALING = 1.1
# Accuracy and evasion scale in additive manner per level
const BATTLESHIP_BASE_ACCURACY_SCALING = 5
const BATTLESHIP_BASE_EVASION_SCALING = 2.5


const MISSILE_DAMAGE_MULTIPLIER = 0.8
const MISSILE_ACCURACY_MULTIPLIER = 10
var MISSILE_DAMAGE = BATTLESHIP_BASE_ATTACK * MISSILE_DAMAGE_MULTIPLIER
var MISSILE_ACCURACY = BATTLESHIP_BASE_ACCURACY * MISSILE_ACCURACY_MULTIPLIER
const MISSILE_SPEED = 200
const MISSILE_FIRE_RATE = 1
const MISSILE_FIRE_RATE_VARIANCE = 0.5

const LASER_DAMAGE_MULTIPLIER = 1.2
const LASER_ACCURACY_MULTIPLIER = 0.5
var LASER_DAMAGE = BATTLESHIP_BASE_ATTACK * LASER_DAMAGE_MULTIPLIER
var LASER_ACCURACY = BATTLESHIP_BASE_ACCURACY * LASER_ACCURACY_MULTIPLIER
const LASER_SPEED = 125
const LASER_FIRE_RATE = 3
const LASER_FIRE_RATE_VARIANCE = 0.5

# Percentage of hp the shield covers and how much it increments per level (additive)
var SHIELD_COVERAGE = 0.2
const SHIELD_COVERAGE_PER_LEVEL = 0.1

# Extra evasion provided by wings and how much it increments per level (additive)
var WINGS_BONUS_EVASION = 20
const WINGS_BONUS_EVASION_PER_LEVEL = 10

const MULTIPLIER_BULLET_TO_SHIP = 1.0
const MULTIPLIER_BULLET_TO_SHIELD = 0.5
const MULTIPLIER_BULLET_TO_TOWER = 1.0
const MULTIPLIER_MISSILE_TO_SHIP = 1.2
const MULTIPLIER_MISSILE_TO_SHIELD = 0.2
const MULTIPLIER_MISSILE_TO_TOWER = 1.0
const MULTIPLIER_LASER_TO_SHIP = 1.4
const MULTIPLIER_LASER_TO_SHIELD = 3.0
const MULTIPLIER_LASER_TO_TOWER = 1.0
