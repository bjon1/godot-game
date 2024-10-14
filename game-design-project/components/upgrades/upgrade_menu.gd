extends Control

@onready var container = $HBoxContainer
@onready var sword_upgrades : PackedScene = preload("res://components/upgrades/sword_upgrades/sword_upgrades.tscn")
@onready var player_upgrades : PackedScene = preload("res://components/upgrades/player_upgrades/player_upgrades.tscn")
@onready var upgrade_array : Array[PackedScene] = [sword_upgrades, player_upgrades]

func enable():
	print(upgrade_array)
	for i in range(3):
		var random_index : int = randi() % upgrade_array.size()
		var new_upgrade : PackedScene = upgrade_array[random_index]
		# Check if upgrade_scene is a valid PackedScene before instantiation
		if new_upgrade:
			var upgrade_instance : Control = new_upgrade.instantiate()
			#upgrade_instance.generate_upgrade()
			container.add_child(upgrade_instance)
		else:
			print("Error: upgrade_scene is null at index ", random_index)
		# Add spacing
		var spacer : Control = Control.new()
		spacer.custom_minimum_size = Vector2(160,0)
		container.add_child(spacer)
