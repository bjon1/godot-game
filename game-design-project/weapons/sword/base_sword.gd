@icon ("res://assets/icons/melee-weapon.png")
extends Node2D
class_name Base_Sword


@onready var main_scene = get_tree().root.get_child(0)

func _process(delta: float) -> void:
	get_input()

func get_input() -> void:
	'''
	this method should be called from the
	_process(delta: float) -> void: function
	in a different class
	'''
	if Input.is_action_pressed("left_click"):
		pass
		
func swing():
	pass
