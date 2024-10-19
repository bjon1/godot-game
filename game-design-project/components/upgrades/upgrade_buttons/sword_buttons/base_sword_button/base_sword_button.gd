extends Button
class_name Base_Sword_Button

@onready var sword : Base_Sword = get_tree().root.get_child(0).get_node("rectangle_guy/player_weapons/sword")
@onready var player_weapons : Node2D = get_tree().root.get_child(0).get_node("rectangle_guy/player_weapons")

func close():
	for child in get_parent().get_children():
		child.queue_free()
	Engine.time_scale = 1

func remove_upgrade(string : String):
	get_parent().get_parent().upgrades_dict.erase(string)
