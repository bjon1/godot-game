extends Node2D

var XP : PackedScene = preload ("res://consumables/xp.tscn")
@onready var main_scene = get_tree().root.get_child(0) 

@export var amount : int = 5



func _on_tree_exiting():
	spawn_xp()

func spawn_xp():
	for i in amount:
		var xp_instance = XP.instantiate()
		xp_instance.position = global_position + Vector2(randf_range(-50, 50), randf_range(-50, 50))
		main_scene.add_child.call_deferred(xp_instance)
