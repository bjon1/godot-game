extends Control

@onready var player : Rectangle_Guy = get_tree().root.get_node("test_world_2/rectangle_guy")
@onready var player_weapons : Node2D = get_tree().root.get_node("test_world_2/rectangle_guy/player_weapons")
@onready var auto_pistol = preload("res://weapons/auto_pistol/auto_pistol.tscn")

func enable():
	show()
	get_child(0).show()
	
func disable():
	queue_free()

func _on_button_button_down():
	var new_weapon = auto_pistol.instantiate()
	player_weapons.add_child(new_weapon)
	player._switch_weapon(1)
	disable()
