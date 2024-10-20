extends Area2D
class_name DropItem

@onready var xp = $"."
@onready var player : Rectangle_Guy = get_tree().root.get_node("test_world_2/rectangle_guy")
@export var xp_value : int = 10

var speed : int = 600

func _ready():
	set_physics_process(false)

func _physics_process(delta):
	var direction = (player.global_position - position).normalized()
	# Only move towards the player if we're further than the threshold
	if position.distance_to(player.global_position) >= 10:
		position += direction * speed * delta
	else:
		# If close enough, collect XP and queue free
		if Engine.time_scale == 1:
			player.collect_xp(xp_value)
			queue_free()
	
func _on_area_entered(area : Area2D) -> void:
	set_physics_process(true)

func _on_area_exited(area):
	set_physics_process(false)
	
