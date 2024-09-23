@icon("res://assets/icons/heavy-bullets.png")
extends CharacterBody2D
class_name Bullet

'''
Note:
	World exists on collision and mask layer 1
	Players exist on collision and mask layer 2
	Enemies exist on collision and mask layer 3
	
	need to be provided when shooting a bullet:
	var direction : float
	var spawn_rotation : float
	var spawn_position : Vector2
	var bullet_damage : float
'''

var collision : KinematicCollision2D

var direction : float
var spawn_rotation : float
var spawn_position : Vector2
var damage : float

@export var speed : float = 800
@export var bullet_tile_damage : int = 1
@export var bullet_tile_penetration : int = 1
@export var bullet_entity_penetration : int = 1
@export var can_break_tile : bool = true

func _ready() -> void:
	global_position = spawn_position
	global_rotation = spawn_rotation

func _process(delta: float) -> void:
	var motion : Vector2 = Vector2(speed, 0) * delta
	collision = move_and_collide(motion)
	_handle_tile_map_layer_collision()

func _handle_tile_map_layer_collision() -> void:
	if collision == null or can_break_tile == false:
		return
	
	if !collision.get_collider().is_class("TileMapLayer"):
		return
	
	var global_tile_position : Vector2 = (collision.get_position() - collision.get_normal())
	collision.get_collider().damage_tile(global_tile_position, bullet_tile_damage)
	bullet_tile_penetration -= 1
	destroy()
			
func _on_bullet_hurt_box_body_entered(body: Node2D) -> void:
	if body.has_method("take_damage"):
		body.take_damage(damage)
		bullet_entity_penetration -= 1
	destroy()
		
func _on_bullet_life_timeout() -> void:
	queue_free()
	
func destroy():
	if bullet_entity_penetration < 1 or bullet_tile_penetration < 1:
		queue_free()
