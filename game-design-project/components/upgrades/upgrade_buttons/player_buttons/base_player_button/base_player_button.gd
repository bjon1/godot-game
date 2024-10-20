extends Button
class_name Base_Player_Button

@onready var player : Rectangle_Guy = get_tree().root.get_child(0).get_node("rectangle_guy")
@onready var player_weapons : Node2D = get_tree().root.get_child(0).get_node("rectangle_guy/player_weapons")

func close():
	for child in get_parent().get_children():
		child.queue_free()
	Engine.time_scale = 1
	player.is_paused = false
	
func remove_upgrade(string : String):
	get_parent().get_parent().upgrades_dict.erase(string)
