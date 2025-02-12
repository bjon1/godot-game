extends Base_Enemy

@onready var player : Rectangle_Guy = get_tree().root.get_child(0).get_node("rectangle_guy")

var avoidance_distance = 50 # Distance to start avoiding other enemies
var max_avoidance_force = 100 # Maximum force of avoidance
var avoidance_weight = 0.4
var player_weight = 1.0

func _ready():
	health = ((player.xp_level + 1) * 60)
	max_health = health

func _physics_process(delta):
	var direction_to_player = (player.global_position - position).normalized()
	var avoidance_direction = Vector2.ZERO

	# Get all enemies in the scene
	var enemies = get_tree().get_nodes_in_group("enemies")
	for enemy in enemies:
		if enemy != self and position.distance_to(enemy.position) < avoidance_distance:
			var away_from_enemy = (position - enemy.position).normalized()
			avoidance_direction += away_from_enemy

	# Normalize the avoidance direction
	if avoidance_direction.length() > 0:
		avoidance_direction = avoidance_direction.normalized()

	# Smooth the avoidance direction
	avoidance_direction = avoidance_direction.lerp(avoidance_direction, 0.1)

	# Combine the player direction and the avoidance direction
	var steering_direction = (direction_to_player * player_weight + avoidance_direction * avoidance_weight).normalized()

	if position.distance_to(player.global_position) > 3:
		position += steering_direction * speed * delta
