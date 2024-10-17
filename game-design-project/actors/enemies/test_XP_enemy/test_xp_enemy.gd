extends Base_Enemy

@onready var player : Rectangle_Guy = get_tree().root.get_node("test_world_2/rectangle_guy")

func _physics_process(delta):
	var direction = (player.global_position - position).normalized()
	position += direction * speed * delta
