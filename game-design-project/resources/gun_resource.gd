extends Resource
class_name Gun_Resource

const stat_cap = 2000000000

var fire_rate_timer : Timer = Timer.new()
var reload_speed_timer : Timer = Timer.new()
var burst_delay_timer : Timer = Timer.new()
var charge_time_timer : Timer = Timer.new()

@export var weapon_name : String
@export var activate_animation : String
@export var shoot_animation : String
@export var reload_animation : String
@export var deactivate_animation : String
@export var out_of_ammo_animation : String

@export_range(0, stat_cap) var ammo_ammount : int					#ammo ammount in gun
@export_range(0, stat_cap) var ammo_reserve : int					#ammo available for reloading
@export_range(0, stat_cap) var magazine_size: int					#amout of ammo to reload
@export_range(0, stat_cap) var max_ammo : int						#max ammo amount allowed at reserve
@export var automatic_fire : bool								#if true weapons fire by holding shoot button

@export var bullet_scene : PackedScene
@export var damage : float										#damage the gun deals
@export_range(0, 1) var accuracy : float						#how accurate the gun is in percentage
@export_range(0, stat_cap) var bullet_count : int					#how many bullets should be fired from one shot
@export_range(0,360) var bullet_spread : float
@export_range(0, stat_cap) var bullet_speed : float
@export_range(0, stat_cap) var tile_damage : int
@export_range(0, stat_cap) var tile_penetration : int				#how many tiles the bullet can penetrate before disappearing
@export_range(0, stat_cap) var enemy_penetration : int				#how many enemies the bullet can penetrate before disappearing

#timed variables
@export_range(0, 300) var fire_rate : float:					#how fast the gun shoots in seconds
	set(value):
		fire_rate = value
		fire_rate_timer.set_wait_time(max(fire_rate, 0.00001))
		
@export_range(0, 300) var burst_delay : float:					#delay between bullets in one shot
	set(value):
		burst_delay = value
		burst_delay_timer.set_wait_time(max(burst_delay, 0.00001))
		
@export_range(0, 300) var reload_speed : float:					#how long it takes to reload
	set(value):
		reload_speed = value
		reload_speed_timer.set_wait_time(max(reload_speed, 0.00001))
			
@export_range(0, 300) var charge_time : float:					#how long the weapon needs to charge before shot
	set(value):
		charge_time = value
		charge_time_timer.set_wait_time(max(charge_time, 0.00001))
		
func initialize() -> void:
	'''
	must be called by the script using this resource
	on the _on_ready() function
	'''
	bullet_spread = deg_to_rad(bullet_spread)
	_initialize_fire_rate_timer()
	_initialize_reload_speed_timer()
	_initialize_burst_delay_timer()

func get_bullet_resource() -> Bullet_Resource:
	var bullet_resource : Bullet_Resource = Bullet_Resource.new()
	bullet_resource.damage = damage
	bullet_resource.speed = bullet_speed
	bullet_resource.tile_damage = tile_damage
	bullet_resource.tile_penetration = tile_penetration
	bullet_resource.enemy_penetration = enemy_penetration
	return bullet_resource
	

func _initialize_fire_rate_timer() -> void:
	fire_rate_timer.set_autostart(false)
	fire_rate_timer.set_one_shot(true)
	fire_rate_timer.set_wait_time(max(fire_rate, 0.00001))

func _initialize_reload_speed_timer() -> void:
	reload_speed_timer.set_autostart(false)
	reload_speed_timer.set_one_shot(true)
	reload_speed_timer.set_wait_time(max(reload_speed, 0.00001))

func _initialize_burst_delay_timer() -> void:
	burst_delay_timer.set_autostart(false)
	burst_delay_timer.set_one_shot(true)
	burst_delay_timer.set_wait_time(max(burst_delay, 0.00001))

func calculate_accuracy() -> float:
	var accuracy_factor = 1 - accuracy
	return randf_range(-accuracy_factor, accuracy_factor)
