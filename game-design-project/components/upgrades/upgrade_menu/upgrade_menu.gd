extends Control
class_name Main_Menu

@onready var container = $HBoxContainer
@onready var player : Rectangle_Guy = get_tree().root.get_child(0).get_node("rectangle_guy")

var upgrades_dict : Dictionary= {
	"sword_damage": preload("res://components/upgrades/upgrade_buttons/sword_buttons/sword_damage/sword_damage.tscn"),
	"sword_size": preload("res://components/upgrades/upgrade_buttons/sword_buttons/sword_size/sword_size.tscn"),
	"sword_speed": preload("res://components/upgrades/upgrade_buttons/sword_buttons/sword_speed/sword_speed.tscn"),
	"player_health": preload("res://components/upgrades/upgrade_buttons/player_buttons/player_health/player_health.tscn"),
	"player_max_health": preload("res://components/upgrades/upgrade_buttons/player_buttons/player_max_health/player_max_health.tscn"),
	"player_pickup_radius": preload("res://components/upgrades/upgrade_buttons/player_buttons/player_pickup_radius/player_pickup_radius.tscn"),
	"player_speed": preload("res://components/upgrades/upgrade_buttons/player_buttons/player_speed/player_speed.tscn"),
} 
var pistol_upgrades_dict : Dictionary= {
	"pistol_accuracy": preload("res://components/upgrades/upgrade_buttons/pistol_buttons/pistol_accuracy/pistol_accuracy.tscn"),
	"pistol_damage": preload("res://components/upgrades/upgrade_buttons/pistol_buttons/pistol_damage/pistol_damage.tscn"),
	"pistol_fire_rate": preload("res://components/upgrades/upgrade_buttons/pistol_buttons/pistol_fire_rate/pistol_fire_rate.tscn"),
	"pistol_max_ammo": preload("res://components/upgrades/upgrade_buttons/pistol_buttons/pistol_max_ammo/pistol_max_ammo.tscn"),
	"pistol_reload_speed": preload("res://components/upgrades/upgrade_buttons/pistol_buttons/pistol_reload_speed/pistol_reload_speed.tscn"),
}

func enable():
	# Get the keys from the dictionary
	var keys = upgrades_dict.keys()
	# Shuffle the keys randomly
	keys.shuffle()
	# Select the first three keys
	var selected_keys = keys.slice(0, 3)
	for key in selected_keys:
		# Instance the scene associated with the key and add it to the container
		var upgrade_scene = upgrades_dict[key].instantiate()
		container.add_child(upgrade_scene)
		
		#var spacer : Control = Control.new()
		#spacer.custom_minimum_size = Vector2(20,0)
		#container.add_child(spacer)


func _on_h_box_container_child_exiting_tree(node):
	if node == get_child(0).get_child(0):
		if player:
			player.play_upgrade_sound()
	
func _on_new_weapon_menu_tree_exiting():
	if player:
		player.play_upgrade_sound()
