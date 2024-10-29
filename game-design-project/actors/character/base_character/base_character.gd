extends CharacterBody2D
class_name Base_Character
'''
Note:
	World exists on collision and mask layer 1
	Players exist on collision and mask layer 2
	Enemies exist on collision and mask layer 3
'''

@export var base_character_debug : bool = false
@export var max_health : float = 100.0
@export var health : float = 100.0
@export var speed : float = 100.0
@export var attack_damage : float = 3.0

@onready var animation_player : AnimationPlayer = $AnimationPlayer
@onready var hurt_sound : AudioStreamPlayer2D = $sfx/hurt_sound

var the_world

func _ready():
	reset_health()
	get_the_world()

func reset_health() -> void:
	if health != max_health:
		health = max_health
	
func get_the_world() -> void:
	var world_group = get_tree().get_nodes_in_group("World")
	if world_group.size() == 0:
		return
	the_world = world_group[0]
	
func clamp_to_map() -> void:
	self.global_position.x = clamp(self.global_position.x, 0.0, the_world.map_size.x)
	self.global_position.y = clamp(self.global_position.y, 0.0, the_world.map_size.y)
	
func take_damage(damage_amount : float) -> void:
	if health > 0:
		animation_player.play("hurt")
		hurt_sound.play()
		if damage_amount > health:
			health = 0
		else:
			health -= damage_amount
		if base_character_debug: print("take_damage(): health ", self.name + ": ", health)
		destroy() #check to destroy character
		animation_player.queue("idle")
		
func destroy() -> void: #using this function on the player can cause the game to crash
	if health <= 0:
		if base_character_debug: print("destroy(): entity ", self.name, ": destroyed")
		queue_free()
		
