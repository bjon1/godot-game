extends Node2D
class_name Weapon

'''
@export var main_scene : Node2D
must be exported in order for bullet position
to not be affected by the weapon's position
after firing.
'''

var bullet_preload = preload("res://weapons/bullets/base_bullet/base_bullet.tscn")
@onready var animation_player : AnimationPlayer = get_node("AnimationPlayer")
@onready var fire_rate_timer : Timer = get_node("fire_rate_timer")

@export var main_scene : Node2D
@export var damage : float = 100
@export var accuracy : float = 50

func get_input() -> void:
	'''
	this method should be called from the
	_process(delta: float) -> void: function
	in a different class
	'''
	if Input.is_action_pressed("ui_accept"):
		shoot()
		
func shoot() -> void:
	if fire_rate_timer.is_stopped():
		#instantiate bullet
		var bullet = bullet_preload.instantiate()
		bullet.direction = rotation
		bullet.spawn_rotation = rotation
		bullet.spawn_position = global_position
		
		#add bullet to scene
		main_scene.add_child.call_deferred(bullet)
		
		animation_player.play("shoot")
		fire_rate_timer.start()
