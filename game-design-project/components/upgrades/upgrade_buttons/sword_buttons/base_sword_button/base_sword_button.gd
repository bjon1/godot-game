extends Button
class_name Base_Sword_Button

@onready var sword : Base_Sword = get_tree().root.get_child(0).get_node("rectangle_guy/player_weapons/sword")

func close():
	for child in get_parent().get_children():
		child.queue_free()
	Engine.time_scale = 1
