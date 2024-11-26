extends TileMapLayer
class_name Base_Map

var tile_size_x : int
var tile_size_y : int

func _ready() -> void:
	var tile_area : Vector2 = get_tile_set().get_tile_size()
	tile_size_x = int(tile_area.x)
	tile_size_y = int(tile_area.y)
	
func is_valid_atlas(tile_health : int, damage_amount : int) -> bool:
	return tile_health > damage_amount
	
func damage_tile(tile_position : Vector2, damage_amount : int) -> void:
	var local_position : Vector2 = self.to_local(tile_position)
	var map_position : Vector2i = self.local_to_map(local_position)
	var tile_data : TileData = self.get_cell_tile_data(map_position)
	
	if tile_data == null:
		return
		
	if tile_data.get_custom_data("breakable") == true:
		if is_valid_atlas(tile_data.get_custom_data("health"), damage_amount):
			var tile_map_cell_source_id = self.get_cell_source_id(map_position)
			var tile_map_cell_atlas_coords = self.get_cell_atlas_coords(map_position) + Vector2i(damage_amount, 0)
			var tile_map_cell_alternative = self.get_cell_alternative_tile(map_position)
			self.set_cell(map_position, tile_map_cell_source_id, tile_map_cell_atlas_coords, tile_map_cell_alternative)
		else:
			destroy_cell(map_position)
	
func damage_tile_area(center : Vector2, radius : float, damage_amount : int) -> void:
	center = Vector2(int(center.x), int(center.y))
	var radius_squared : int = int(radius * radius)
	
	#area of a box
	var range_x : Array = range(center.x - radius, center.x + radius + 1, tile_size_x)
	var range_y : Array = range(center.y - radius, center.y + radius + 1, tile_size_y)
	
	#check where area of circle and box match
	for x in range_x:
		var x2 : int = (x - center.x)**2
		for y in range_y:
			var y2 : int = (y - center.y)**2
			if x2 + y2 <= radius_squared:
				damage_tile(Vector2(x, y), damage_amount)

func explode_tile_area(center : Vector2, damage_amount : int, blast_mask : Array) -> void:
	'''
	explode_tile_area damages tiles in the area of a circle from the center of impact with
	the assistance of a blast mask which is pre calculated based off of the user's blast radius
	and then translated to the new center of impact
	
	
	blast_mask contains the x and y coordinates of a quarter circle in the first quadrant
	centered at 0,0 with a radius specified by the user when creating their weapon. 
	The z coordinate contains the damage scale calculated using the formula: (1 - (distance/radius))
	where the farther the coordinates are from the center of the explosion, the less damage the blast deals.
	'''
	if damage_amount == 0:
		return
		
	var size : int = blast_mask.size()
	var h : int = int(center.x)
	var k : int = int(center.y)
	for i in size:
		var arr : Array = blast_mask[i]
		var x : int = arr[0]
		var y : int = arr[1]
		var damage_scale : float = arr[2]
		var damage : int = max(int(damage_amount * damage_scale), 1)
		
		damage_tile(Vector2(x+h, y+k), damage)		#Quadrant 1
		damage_tile(Vector2(-x+h, -y+k), damage)	#Quadrant 3
		if y!=0 and x!=0:	#prevent overlap between quadrants
			damage_tile(Vector2(-x+h, y+k), damage)	#Quadrant 2
			damage_tile(Vector2(x+h, -y+k), damage)	#Quadrant 4
			
			
func destroy_cell(map_position) -> void:
	#handle loot table logic
	erase_cell(map_position)
