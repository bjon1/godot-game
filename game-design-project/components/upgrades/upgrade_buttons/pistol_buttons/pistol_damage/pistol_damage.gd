extends Base_Upgrade_Button

@onready var auto_pistol = get_tree().root.get_child(0).get_node("rectangle_guy/player_weapons/auto_pistol")

func _on_button_up():
	auto_pistol.res.damage += 10
	close()
