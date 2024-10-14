extends Control
class_name Sword_Upgrades

static var shared_array : Array[int] = [0, 1, 2] 
var reset_array : Array[int] = [0, 1, 2] 
@onready var sword : Base_Sword = get_tree().root.get_node("test_world_2/rectangle_guy/player_weapons/sword")
var random_button 

func _ready():
	if shared_array.size() > 0:
		var random_index = randi() % shared_array.size()
		random_button = shared_array[random_index]
		get_child(random_button).show()
		#random_button.grab_focus()
		shared_array.erase(random_button)

func disable():
	for child in get_parent().get_children():
		child.queue_free()
	
func _on_size_button_down():
	sword.upgrade_size(0.25)
	disable()

func _on_speed_button_down():
	sword.upgrade_speed(0.25)
	disable()

func _on_damage_button_down():
	sword.damage += 5
	disable()

func _on_tree_exiting():
	shared_array = reset_array
