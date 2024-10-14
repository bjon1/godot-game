extends Control
class_name Player_Upgrades

static var shared_array : Array[int] = [0, 1, 2] 
var reset_array : Array[int] = [0, 1, 2] 
@onready var player : Rectangle_Guy = get_tree().root.get_node("test_world_2/rectangle_guy")
var random_button 

func _ready():
	if shared_array.size() > 0:
		var random_index = randi() % shared_array.size()
		random_button = shared_array[random_index]
		get_child(random_button).show()
		shared_array.erase(random_button)

func disable():
	for child in get_parent().get_children():
		child.queue_free()

	
func _on_pickup_radius_button_down():
	player.upgrade_pickup_area(5.0)
	disable()

func _on_health_button_down():
	player.max_health += 50
	player.health += 50
	disable()
	
func _on_speed_button_down():
	player.speed += 100
	disable()
	
func _on_tree_exiting():
	shared_array = reset_array
