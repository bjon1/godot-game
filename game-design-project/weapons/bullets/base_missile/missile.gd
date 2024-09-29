extends Base_Bullet
class_name Missile

@onready var blast_area : Area2D = $blast_area
@onready var blast_area_collision : CollisionShape2D = $blast_area/blast_area_collision
@onready var explosion_particles : GPUParticles2D = $explosion_01
@onready var sprite : Sprite2D = $Sprite2D
var is_exploding : bool = false

func set_collision():
	blast_area.set_collision_mask_value(res.target_layer, true)
	set_collision_mask_value(res.target_layer, true)
	
func _handle_collision() -> void:
	if collision == null:
		return
	if is_exploding == false:
		explode()
		
func explode() -> void:
	is_exploding = true
	
	blast_area_collision.get_shape().set_radius(res.blast_radius)
	var blast_target : Array = blast_area.get_overlapping_bodies()
	
	for target in blast_target:
		if target.has_method("take_damage"):	target.take_damage(res.damage)
		elif target.is_class("TileMapLayer"):	target.explode_tile_area(global_position, res.tile_damage, res.blast_mask)
	
	explosion_particles.set_emitting(true)
	sprite.visible = false
	await explosion_particles.finished
	queue_free()
