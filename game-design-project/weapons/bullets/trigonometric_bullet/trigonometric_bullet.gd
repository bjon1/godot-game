extends "res://weapons/bullets/base_bullet/base_bullet.gd"

enum MODE{
	SIN, COS, TAN, CSC, SEC, COT, ARCSIN, ARCCOS, ARCTAN, ARCSC, ARCSEC, ARCCOT
}
@onready var perpendicular_direction : Vector2 = Vector2(0, -1).rotated(spawn_rotation)
var time_passed : float = 0.0

#sinosoidal movement:
@export var frequency : float = 40
@export var amplitude : float = 10

func _ready() -> void:
	global_position = spawn_position
	global_rotation = spawn_rotation

func _process(delta: float) -> void:
	time_passed += delta
	var wave_offset = sin(time_passed * frequency) * amplitude
	var offset_position = Vector2(res.speed, 0).rotated(spawn_rotation)
	var oscillation = perpendicular_direction * wave_offset
	var motion : Vector2 = offset_position + oscillation
	
	collision = move_and_collide(motion)
	_handle_tile_map_layer_collision()
