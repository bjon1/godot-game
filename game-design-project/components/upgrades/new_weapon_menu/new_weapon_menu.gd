extends Control

@onready var player : Rectangle_Guy = get_tree().root.get_node("test_world_2/rectangle_guy")
@onready var player_weapons : Node2D = get_tree().root.get_node("test_world_2/rectangle_guy/player_weapons")
@onready var auto_pistol = preload("res://weapons/auto_pistol/auto_pistol.tscn")
@onready var level_up_label = $Level_up_label

func enable():
	show()
	get_child(0).show()
	level_up_label.visible = true

func disable():
	queue_free()
	Engine.time_scale = 1
	player.is_paused = false
	level_up_label.visible = false
	
func _on_button_button_up():
	var new_weapon = auto_pistol.instantiate()
	player_weapons.add_child(new_weapon)
	player._switch_weapon(1)
	var main_menu : Main_Menu = get_parent().get_node("UpgradeMenu")
	main_menu.upgrades_dict.merge(main_menu.pistol_upgrades_dict)
	disable()
