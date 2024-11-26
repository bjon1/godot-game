extends Node2D

@export var noise_height_text: NoiseTexture2D
var noise : Noise
var noise_value_array : Array
var width : int = 100
var height : int = 100

@onready var tile_map_layer : TileMapLayer = $TileMapLayer
var source_id = 0
var seed = 0
var water_atlas = Vector2i(0, 18)
var dirt_atlas = Vector2i(0,13)
var stone_atlas = Vector2i(0,7)
var sand_atlas = Vector2i(0,3)

func _ready():
	seed = randi()%1000
	noise_height_text.noise.seed = seed
	noise = noise_height_text.noise
	generate_world()

func generate_world():
	for x in range(-width/2, width/2):
		for y in range(-height/2, height/2):
			var noise_val = noise.get_noise_2d(x,y)
			noise_value_array.append(noise_val)
			if noise_val >= 0.2:
				tile_map_layer.set_cell(Vector2(x,y), source_id, sand_atlas)
			elif noise_val >= 0.1:
				tile_map_layer.set_cell(Vector2(x,y), source_id, stone_atlas)
			elif noise_val >= -0.1:
				tile_map_layer.set_cell(Vector2(x,y), source_id, dirt_atlas)
			#elif noise_val >= -0.5:
			else:
				tile_map_layer.set_cell(Vector2(x,y), source_id, water_atlas)
func generate_chunk():
	for x in range(-width/2, width/2):
		for y in range(-height/2, height/2):
			var noise_val = noise.get_noise_2d(x,y)
			noise_value_array.append(noise_val)
			if noise_val >= 0.2:
				tile_map_layer.set_cell(Vector2(x,y), source_id, sand_atlas)
			elif noise_val >= 0.1:
				tile_map_layer.set_cell(Vector2(x,y), source_id, stone_atlas)
			elif noise_val >= -0.1:
				tile_map_layer.set_cell(Vector2(x,y), source_id, dirt_atlas)
			#elif noise_val >= -0.5:
			else:
				tile_map_layer.set_cell(Vector2(x,y), source_id, water_atlas)
				
				
	print("highest noise value: ", noise_value_array.max())
	print("lowest noise value: ", noise_value_array.min())
