extends "res://base_character.gd"

'''
Note:
	World exists on collision and mask layer 1
	Players exist on collision and mask layer 2
	Enemies exist on collision and mask layer 3
'''

enum{UP, DOWN}
@onready var weapons : Node2D = get_node("player_weapons")
var current_weapon : Node2D

func _ready() -> void:
	current_weapon = weapons.get_child(0)

func _process(delta: float) -> void:
	var mouse_direction : Vector2 = (get_global_mouse_position() - global_position).normalized()
	#handle player movement
	
func _switch_weapon(direction : int) -> void:
	var index : int = current_weapon.get_index()
	if direction == UP:
		index -= 1
		if index < 0:
			index = weapons.get_child_count() - 1
	else:
		index += 1
		if index > weapons.get_child_count() - 1:
			index = 0
			
	current_weapon.hide()
	current_weapon = weapons.get_child(index)
	current_weapon.show()
