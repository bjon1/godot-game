extends Button
class_name Base_Pistol_Button

@onready var auto_pistol : Auto_Pistol = get_tree().root.get_child(0).get_node("rectangle_guy/player_weapons/auto_pistol")

func close():
	for child in get_parent().get_children():
		child.queue_free()
	Engine.time_scale = 1

func remove_upgrade(string : String):
	get_parent().get_parent().upgrades_dict.erase(string)
