extends Control

@onready var button : Button = $Button
@onready var button_3 : Button = $Button3
@onready var button_2 : Button = $Button2
@onready var player : Rectangle_Guy = get_tree().get_root().get_child(0).get_node("rectangle_guy")
@onready var sword : Base_Sword = get_tree().root.get_node("test_world_2/rectangle_guy/player_weapons/sword")
@onready var player_weapons = get_tree().get_root().get_child(0).get_node("rectangle_guy/player_weapons")

func _ready():
	pass

func _on_button_pressed():
	sword.upgrade_size(0.25)
	close_menu()

func _on_button_2_pressed():
	player.upgrade_pickup_area(5)
	close_menu()

func _on_button_3_pressed():
	sword.damage += 5
	close_menu()

func close_menu():
	player.set_process(true)
	player.current_weapon.set_process(true)
	queue_free()
