extends TileMapLayer

@export var tile_map_layer : TileMapLayer

func is_valid_atlas(tile_data : TileData, damage_amount : float):
	return tile_data.get_custom_data("health") > damage_amount
	
func damage_tile(item_position : Vector2) -> void:
	var local_position : Vector2 = tile_map_layer.to_local(item_position)
	var map_position : Vector2i = tile_map_layer.local_to_map(local_position)
	var tile_data : TileData = tile_map_layer.get_cell_tile_data(map_position)
	
	if tile_data == null:
		return
		
	if tile_data.get_custom_data("breakable") == true:
		var tile_map_cell_source_id = tile_map_layer.get_cell_source_id(map_position)
		var tile_map_cell_atlas_coords = tile_map_layer.get_cell_atlas_coords(map_position) + Vector2i(1, 0)
		var tile_map_cell_alternative = tile_map_layer.get_cell_alternative_tile(map_position)
		if is_valid_atlas(tile_data, 2):
			tile_map_layer.set_cell(map_position, tile_map_cell_source_id, tile_map_cell_atlas_coords, tile_map_cell_alternative)
		else:
			erase_cell(map_position)
