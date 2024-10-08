extends Node2D

@onready var rectangle_guy : CharacterBody2D = $".."

func _process(delta):
	var global_mouse_position : Vector2 = get_global_mouse_position()
	
	var movement_offset : Vector2 = rectangle_guy.velocity * delta
	
	look_at(global_mouse_position + movement_offset)
