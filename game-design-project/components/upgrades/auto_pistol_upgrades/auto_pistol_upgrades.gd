extends Control
class_name Auto_Pistol_Upgrades

static var shared_array : Array[int] = [0, 1, 2, 3, 4] 
var reset_array : Array[int] = [0, 1, 2, 3, 4] 
@onready var player : Rectangle_Guy = get_tree().root.get_node("test_world_2/rectangle_guy")
@onready var auto_pistol : Auto_Pistol = get_tree().root.get_node("test_world_2/rectangle_guy/player_weapons/auto_pistol")
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

func _on_tree_exiting():
	shared_array = reset_array

func _on_damage_button_down():
	auto_pistol.res.damage += 10
	disable()

func _on_reload_speed_button_down():
	pass
	auto_pistol.res.reload_speed -= 0.2
	disable()

func _on_ammo_button_down():
	auto_pistol.res.ammo_reserve += 30
	disable()

func _on_fire_rate_button_down():
	auto_pistol.res.fire_rate -= 0.02
	disable()
	
func _on_accuracy_button_down():
	auto_pistol.res.accuracy += 0.1
	disable()
	
