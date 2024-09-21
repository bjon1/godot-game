extends "res://base_character.gd"

'''
Note:
	World exists on collision and mask layer 1
	Players exist on collision and mask layer 2
	Enemies exist on collision and mask layer 3
'''

@export var base_enemy_debug : bool = false

var selected_target
var damageable_targets_in_range : Array

func select_target() -> void:
	var targets: Array = get_tree().get_nodes_in_group("Player")
	
	if targets.size() == 0:
		return
	
	targets.shuffle()
	
	selected_target = targets.front()


func _on_attack_area_body_entered(body: Node2D) -> void:
	#Area 2d monitors collision layer 2 (Players)
	if body.has_method("take_damage"):
		damageable_targets_in_range.append(body)
		if base_enemy_debug: print("_on_attack_area_body_entered(): entity ", body.name, ": entered")
		
		
func _on_attack_area_body_exited(body: Node2D) -> void:
	#Area 2d monitors collision layer 2 (Players)
	if damageable_targets_in_range.has(body):
		damageable_targets_in_range.erase(body)
		if base_enemy_debug: print("_on_attack_area_body_exited(): entity ", body.name, ": exited")
		
func _on_attack_interval_timer_timeout() -> void:
	#timer for enemy attack cooldown
	if damageable_targets_in_range.size() == 0:
		return

	for target in damageable_targets_in_range:
		if target.has_method("take_damage"):
			target.take_damage(attack_damage)
