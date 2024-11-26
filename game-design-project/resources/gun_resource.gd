extends Resource
class_name Gun_Resource

const stat_cap : int = 2000000000
const timer_cap_min : float = 0.00001 #treated as 0
static var blast_mask : Array

var fire_rate_timer : Timer = Timer.new()
var reload_speed_timer : Timer = Timer.new()
var burst_delay_timer : Timer = Timer.new()
var charge_time_timer : Timer = Timer.new()

enum Target_Layers{
	Player,
	Enemy
}

@export var has_infinite_ammo : bool = false
##Determines which group can be damaged by the bullet
@export var weapon_target : Target_Layers = Target_Layers.Enemy
##Name that will be displayed in-game
@export var weapon_name : String

@export_group("Animations")
@export var activate_animation : String
@export var shoot_animation : String
@export var reload_animation : String
@export var deactivate_animation : String
@export var out_of_ammo_animation : String

@export_group("Weapon Capacity")
##If true, weapons can fire by holding shoot button instead of tapping repeatedly
@export var automatic_fire : bool
##ammo loaded in the gun
@export_range(0, stat_cap) var ammo_ammount : int
##max ammo ammount that gun can load
@export_range(0, stat_cap) var magazine_size: int
##starting ammo in reserve
@export_range(0, stat_cap) var ammo_reserve : int
##max ammo amount allowed at reserve
@export_range(0, stat_cap) var max_reserve_ammo : int


@export_group("Weapon Stats")
##Bullet that the gun uses
@export var bullet_scene : PackedScene
##Determines the amount of damage a gun deals
@export var damage : float
##Determines bullet deviance from expected path in percentage, 0 means low accuracy, 1 means perfect accuracy
@export_range(0, 1) var accuracy : float
##How many bullets should be fired from one shot
@export_range(0, stat_cap) var bullet_count : int
##Defines the angle (Degrees) at which two or more bullets fire from eachoter 
@export_range(0,360) var bullet_spread : float
##Speed of bullet when fired
@export_range(0, stat_cap) var bullet_speed : float
##How much damage a bullet does to a tile
@export_range(0, stat_cap) var tile_damage : int
##How many tiles the bullet can penetrate before disappearing
@export_range(0, stat_cap) var tile_penetration : int
##How many enemies the bullet can penetrate before disappearing
@export_range(0, stat_cap) var enemy_penetration : int
##(Only applies to explosive bullets) determines blast radius in pixels
@export_range(0, 50000) var blast_radius : float:
	set(value):
		blast_radius = value
		blast_mask.clear()
		_calculate_blast_mask()

@export_category("Timed Variables")
##How quickly bullets can be fired
@export_range(0, 300) var fire_rate : float:
	set(value):
		fire_rate = value
		fire_rate_timer.set_autostart(false)
		fire_rate_timer.set_one_shot(true)
		fire_rate_timer.set_wait_time(max(fire_rate, timer_cap_min))

##Delay between bullets in a gun that shoots multiple shots (0 makes all bullets fire simultaneously)
@export_range(0, 300) var burst_delay : float:
	set(value):
		burst_delay = value
		burst_delay_timer.set_autostart(false)
		burst_delay_timer.set_one_shot(true)
		burst_delay_timer.set_wait_time(max(burst_delay, timer_cap_min))

##How quickly a weapon reloads
@export_range(0, 300) var reload_speed : float:
	set(value):
		reload_speed = value
		reload_speed_timer.set_autostart(false)
		reload_speed_timer.set_one_shot(true)
		reload_speed_timer.set_wait_time(max(reload_speed, timer_cap_min))

##How long the weapon needs to charge before shot
@export_range(0, 300) var charge_time : float:
	set(value):
		charge_time = value
		charge_time_timer.set_wait_time(max(charge_time, timer_cap_min))

func initialize():
	#call from func _ready() on the class using this resource
	bullet_spread = deg_to_rad(bullet_spread)
	_calculate_blast_mask()
	
func get_bullet_resource() -> Bullet_Resource:
	var bullet_resource : Bullet_Resource = Bullet_Resource.new()
	bullet_resource.target_layer = weapon_target + 2
	bullet_resource.damage = damage
	bullet_resource.speed = bullet_speed
	bullet_resource.tile_damage = tile_damage
	bullet_resource.tile_penetration = tile_penetration
	bullet_resource.enemy_penetration = enemy_penetration
	bullet_resource.blast_radius = blast_radius
	bullet_resource.blast_mask = blast_mask
	return bullet_resource

func has_burst_delay() -> bool:
	return burst_delay_timer.get_wait_time() > timer_cap_min
	
func calculate_accuracy() -> float:
	var accuracy_factor = 1 - accuracy
	return randf_range(-accuracy_factor, accuracy_factor)

func can_reload() -> bool:
	return ammo_reserve > 0 and not (ammo_ammount == magazine_size)

func reload_weapon() -> void:
	#Give back ammo loaded in the weapon to the reserve
	ammo_reserve += ammo_ammount
	ammo_ammount = 0
	
	#Prevent taking more ammo than available
	var ammo_to_reload : int = min(ammo_reserve, magazine_size)
	ammo_reserve -= ammo_to_reload
	ammo_ammount += ammo_to_reload

func has_ammo() -> bool:
	return ammo_ammount > 0 or has_infinite_ammo
	
		
	
func _calculate_blast_mask() -> void:
	'''
	experimental algorithm:
	This algorithm stores a mask of the plot to every point inside 
	the semicircle of the blast radius in order to reduce the number
	of iterations and calculations that need to be made when damaging
	tiles.
	
	the mask is stored as a static variable because when a bullet resource
	is created, it should have a fixed blast_mask across all of them which
	also drastically reduces memory usage since we have one instance of this
	mask shared amongst all of them
	
	This semicircle mask is passed to the TileMapLayer where it will
	translate it to match the center of the explosion and iterate over
	the mask to damage tiles given their coordinates.
	
	I created this algorithm based off the formula for a circle:
	(x - h)^2 + (y- k)^2 = r^2
	where x and y are the coordinates to the center of the circle,
	and h and k are the x and y translation respectively.
	
	By expanding this formula we get:
	x^2 + y^2 + h(-2x + h) + k(-2y + k) = r^2
	
	this masks, stores all the values of the iteration of x^2 and y^2 and
	2x and 2y to reduce the number of calculations made by the TileMapLayer
	specially given that explosive projectile calculations are very repetitive
	
	The way we plot the semicircle is by iterating over a bounding box of size
	length * width where (length = width = radius). This area includes the area of
	the semi circle inside it. We know that a plot lies inside the semi circle when 
	x^2 + y^2 <= r^2. By masking all the plots of the semicircle, we dont have to keep
	drawing the bounding box and checking the plots every time.
	'''
	if blast_radius < 32:
		return
	var radius : int = int(blast_radius)
	var radius_squared : int = radius * radius
	
	#area of a box
	var range_x : Array = range(0, radius + 1, 32)
	var range_y : Array = range(0, radius + 1, 32)
	

	#check where area of circle and box match
	for x in range_x:
		var x2 : int = (x*x)
		for y in range_y:
			var y2 : int = (y*y)
			if x2 + y2 <= radius_squared:
				var distance : float = sqrt((x2 + y2))
				var damage_scale : float = (1 - (distance/radius))
				blast_mask.append([x, y, damage_scale])
