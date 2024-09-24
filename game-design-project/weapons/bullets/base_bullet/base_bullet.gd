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
var res : Bullet_Resource

var direction : Vector2
var spawn_position : Vector2
var spawn_rotation : float

func _ready() -> void:
	global_position = spawn_position
	global_rotation = spawn_rotation
	direction = Vector2.RIGHT.rotated(spawn_rotation)

func _process(delta: float) -> void:
	#var motion : Vector2 = Vector2(res.speed, 0) * delta
	var motion : Vector2 = direction * res.speed * delta
	collision = move_and_collide(motion)
	_handle_tile_map_layer_collision()

func _handle_tile_map_layer_collision() -> void:
	if collision == null:
		return
	
	if !collision.get_collider().is_class("TileMapLayer"):
		return
	
	var global_tile_position : Vector2 = (collision.get_position() - collision.get_normal())
	collision.get_collider().damage_tile(global_tile_position, res.tile_damage)
	res.tile_penetration -= 1
	destroy()
			
func _on_bullet_hurt_box_body_entered(body: Node2D) -> void:
	if body.has_method("take_damage"):
		body.take_damage(res.damage)
		res.enemy_penetration -= 1
	destroy()
		
func _on_bullet_life_timeout() -> void:
	queue_free()
	
func destroy() -> void:
	if res.enemy_penetration < 0 or res.tile_penetration < 0:
		queue_free()
