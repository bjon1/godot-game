extends Base_Upgrade_Button

@onready var auto_pistol_scene = preload("res://weapons/auto_pistol/auto_pistol.tscn")
@onready var upgrade_menu : Upgrade_Menu = get_tree().root.get_child(0).get_node("rectangle_guy/CanvasLayer/UpgradeMenu")

func _on_button_up():
	var new_weapon = auto_pistol_scene.instantiate()
	player_weapons.add_child(new_weapon)
	player._switch_weapon(1)
	upgrade_menu.upgrades_dict.merge(upgrade_menu.pistol_upgrades_dict)
	close()
