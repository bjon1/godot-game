@icon("res://assets/icons/pistol-gun.png")
extends Node2D
class_name Base_Gun

'''
@export var main_scene : Node2D
must be exported in order for bullet position
to not be affected by the weapon's position
after firing.
'''

@export var main_scene : Node2D
@export var res : Gun_Resource

var is_shooting = false

func _ready() -> void:
	res.initialize()
	add_child(res.fire_rate_timer)
	add_child(res.burst_delay_timer)
	add_child(res.reload_speed_timer)
	
func _process(delta: float) -> void:
	get_input()

func get_input() -> void:
	'''
	this method should be called from the
	_process(delta: float) -> void: function
	in a different class
	'''
	if res.automatic_fire == true and Input.is_action_pressed("left_click"):
		shoot()
	elif Input.is_action_just_pressed("left_click"):
		shoot()
	if Input.is_action_just_pressed("reload"):
		reload()
		
func shoot() -> void:
	if _can_shoot():
		is_shooting = true
		for i in res.bullet_count:
			#instantiate bullet
			var bullet = res.bullet_scene.instantiate()
			bullet.spawn_position = global_position
			bullet.spawn_rotation = _calculate_bullet_spread(i) + res.calculate_accuracy()
			bullet.res = res.get_bullet_resource()
			
			#add bullet to scene
			main_scene.add_child.call_deferred(bullet)
			
			if res.bullet_count > 1 and res.has_burst_delay():
				res.burst_delay_timer.start()
				await res.burst_delay_timer.timeout
		is_shooting = false
		res.fire_rate_timer.start()

func reload() -> void:
	pass

func _can_shoot() -> bool:
	return res.fire_rate_timer.is_stopped() and res.reload_speed_timer.is_stopped() and not is_shooting
	
func _calculate_bullet_spread(i : int) -> float:
	if res.bullet_count > 1:
		var increment = res.bullet_spread / (res.bullet_count - 1)
		return (global_rotation + increment * i - res.bullet_spread / 2)
	return global_rotation
