extends Sprite

onready var hitbox_area = get_node("HitboxArea")
onready var stat_provider = get_parent().get_node("StatProvider")
onready var current_level = get_parent().current_level

var max_shield
var shield_amount
var team_group_name

func _ready():
	_init_stats()
	_connect_to_signals()

	hitbox_area.add_to_group(team_group_name)

func set_team_group_name(team_group_name):
	self.team_group_name = team_group_name
	add_to_group(team_group_name)

func _init_stats():
	shield_amount = stat_provider.get_shield_amount_for_level(current_level)
	max_shield = shield_amount

func _connect_to_signals():
	hitbox_area.connect("area_enter", self, "_on_area_enter")

func _on_area_enter(area):
	if !area.is_in_group(team_group_name) && area.is_in_group("Projectile"):
		var body = area.get_parent()
		# TODO: calculate accuracy

		_receive_damage(body.get_damage_for_entity("shield"))

func _receive_damage(damage):
	shield_amount -= damage
	print("remaining shield: ", shield_amount)
	if (shield_amount <= 0):
		# TODO: emit signal?
		# emit_signal("destroyed")
		queue_free()

