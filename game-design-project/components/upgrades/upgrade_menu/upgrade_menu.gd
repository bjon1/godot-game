extends Control

@onready var container = $HBoxContainer
var upgrades_dict : Dictionary= {
	"sword_damage": preload("res://components/upgrades/upgrade_buttons/sword_buttons/sword_damage/sword_damage.tscn"),
	"sword_size": preload("res://components/upgrades/upgrade_buttons/sword_buttons/sword_size/sword_size.tscn"),
	"sword_speed": preload("res://components/upgrades/upgrade_buttons/sword_buttons/sword_speed/sword_speed.tscn"),
} 

func enable():
	# Get the keys from the dictionary
	var keys = upgrades_dict.keys()
	# Shuffle the keys randomly
	keys.shuffle()
	# Select the first three keys
	var selected_keys = keys.slice(0, 3)
	print(selected_keys)
	for key in selected_keys:
		# Instance the scene associated with the key and add it to the container
		var upgrade_scene = upgrades_dict[key].instantiate()
		container.add_child(upgrade_scene)
		
		var spacer : Control = Control.new()
		spacer.custom_minimum_size = Vector2(20,0)
		container.add_child(spacer)
		
