extends Node2D

@onready var player : CharacterBody2D = $rectangle_guy

@export var noise_height_text: NoiseTexture2D
var noise : Noise
var noise_value_array : Array
var width : int = 100
var height : int = 100

@onready var tile_map_layer : TileMapLayer = $destructible_tile_map_layer
@onready var chunk : Chunk = Chunk.new(tile_map_layer)

var source_id = 0
var water_atlas = Vector2i(0, 18)
var dirt_atlas = Vector2i(0,13)
var stone_atlas = Vector2i(0,7)
var sand_atlas = Vector2i(0,3)

@onready var chunk_loader_thread : Thread = Thread.new()
@onready var timer : Timer = $Timer

func _ready():
	noise_height_text.noise.seed = randi()%1000
	noise = noise_height_text.noise
	print("highest noise value: ", noise_value_array.max())
	print("lowest noise value: ", noise_value_array.min())
	
func generate_chunk() -> void:
	var chunk_pos : Vector2 = chunk.pos_to_chunk(player.global_position)
	var surrounding_chunks : Array = chunk.get_surrounding_chunks(chunk_pos)
	var chunk_mask : Array = chunk.chunk_mask

	for current_chunk : Vector2 in surrounding_chunks:
		if chunk.is_loaded(current_chunk):
			continue
		chunk.add_chunk(current_chunk)
		
		for coordinate : Array in chunk_mask:
			var x : int = coordinate[0] + (current_chunk.x * chunk.chunk_size)
			var y : int = coordinate[1] + (current_chunk.y * chunk.chunk_size)
			
			var noise_val : float = noise.get_noise_2d(x,y)
			noise_value_array.append(noise_val)
			if noise_val >= 0.2:
				tile_map_layer.set_cell(Vector2(x,y), source_id, sand_atlas)
			elif noise_val >= 0.1:
				tile_map_layer.set_cell(Vector2(x,y), source_id, stone_atlas)
			elif noise_val >= -0.1:
				tile_map_layer.set_cell(Vector2(x,y), source_id, dirt_atlas)
			else:
				tile_map_layer.set_cell(Vector2(x,y), source_id, water_atlas)

func chunk_loader() -> void:
	generate_chunk()
		
func _exit_tree() -> void:
	chunk_loader_thread.wait_to_finish()


func _on_timer_timeout() -> void:
	generate_chunk()
