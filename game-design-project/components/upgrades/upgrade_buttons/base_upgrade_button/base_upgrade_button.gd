extends Button
class_name Base_Upgrade_Button

@onready var sword : Base_Sword = get_tree().root.get_child(0).get_node("rectangle_guy/player_weapons/sword")
@onready var player_weapons : Node2D = get_tree().root.get_child(0).get_node("rectangle_guy/player_weapons")
@onready var player : Rectangle_Guy = get_tree().root.get_child(0).get_node("rectangle_guy")


func close():
	var UpgradeMenu = get_parent().get_parent()
	UpgradeMenu.closing()
	for child in get_parent().get_children():
		child.queue_free()
	Engine.time_scale = 1
	player.is_paused = false
	
func remove_upgrade(string : String):
	get_parent().get_parent().upgrades_dict.erase(string)
