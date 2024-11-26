extends Node2D
class_name Chunk

var loaded_chunks : HashSet = HashSet.new()
var unloaded_chunks : HashSet = HashSet.new()

var tile_map_layer

const chunk_size = 16
const render_distance = 2
@onready var chunk_mask : Array

func _init(tile_map_layer : TileMapLayer) -> void:
	self.tile_map_layer = tile_map_layer
	chunk_mask = _calculate_chunk_mask()
	
func map_to_chunk(pos : Vector2) -> Vector2:
	var x : int = pos.x / chunk_size
	var y : int = pos.y / chunk_size
	return Vector2(x, y)
	
func pos_to_map(pos : Vector2) -> Vector2:
	pos = tile_map_layer.to_local(pos)
	pos = tile_map_layer.local_to_map(pos)
	return pos

func pos_to_chunk(pos : Vector2) -> Vector2:
	pos = pos_to_map(pos)
	pos = map_to_chunk(pos)
	return pos

func get_surrounding_chunks(chunk : Vector2, radius : int = render_distance) -> Array:
	var surrounding_chunks : Array
	for x in range(chunk.x - radius, chunk.x + radius + 1):
		for y in range(chunk.y - radius, chunk.y + radius + 1):
			surrounding_chunks.append(Vector2(x,y))
	return surrounding_chunks
	
func is_loaded(chunk : Vector2) -> bool:
	return loaded_chunks.has(chunk)
	
func add_chunk(chunk : Vector2) -> void:
	loaded_chunks.add(chunk)
			
func _calculate_chunk_mask() -> Array:
	var mask : Array
	for x in range(-chunk_size/2, chunk_size/2):
		for y in range(-chunk_size/2, chunk_size/2):
			mask.append([x, y])
	return mask
