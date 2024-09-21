extends TileMapLayer
class_name Map

func is_valid_atlas(tile_data : TileData, damage_amount : float):
	return tile_data.get_custom_data("health") > damage_amount
	
func damage_tile(tile_position : Vector2, damage_amount : int) -> void:
	var local_position : Vector2 = self.to_local(tile_position)
	var map_position : Vector2i = self.local_to_map(local_position)
	var tile_data : TileData = self.get_cell_tile_data(map_position)
	
	if tile_data == null:
		return
		
	if tile_data.get_custom_data("breakable") == true:
		var tile_map_cell_source_id = self.get_cell_source_id(map_position)
		var tile_map_cell_atlas_coords = self.get_cell_atlas_coords(map_position) + Vector2i(1, 0)
		var tile_map_cell_alternative = self.get_cell_alternative_tile(map_position)
		if is_valid_atlas(tile_data, damage_amount):
			self.set_cell(map_position, tile_map_cell_source_id, tile_map_cell_atlas_coords, tile_map_cell_alternative)
		else:
			destroy_cell(map_position)
			
func destroy_cell(map_position) -> void:
	#handle loot table logic
	erase_cell(map_position)
