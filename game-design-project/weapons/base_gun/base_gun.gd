@icon("res://assets/icons/pistol-gun.png")
extends Node2D
class_name Gun

'''
@export var main_scene : Node2D
must be exported in order for bullet position
to not be affected by the weapon's position
after firing.

all stats in the weapon class must be passed to the bullet
(except for fire rate)
'''

var bullet_preload = preload("res://weapons/bullets/base_bullet/base_bullet.tscn")
@onready var animation_player : AnimationPlayer = get_node("AnimationPlayer")
@export var main_scene : Node2D

#weapon stats:
@onready var fire_rate_timer : Timer = get_node("fire_rate_timer")
		
@export var damage : float = 100:
	set(value):
		damage = value
		
@export var accuracy : float = 50:
	set(value):
		accuracy = value

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("left_click"):
		shoot()
		
func get_input() -> void:
	'''
	this method should be called from the
	_process(delta: float) -> void: function
	in a different class
	'''
	if Input.is_action_pressed("left_click"):
		shoot()
		
func shoot() -> void:
	if fire_rate_timer.is_stopped():
		#instantiate bullet
		var bullet = bullet_preload.instantiate()
		
		#bullet positioning
		bullet.direction = rotation
		bullet.spawn_rotation = rotation
		bullet.spawn_position = global_position
		
		#bullet stats
		bullet.damage = damage
		
		#add bullet to scene
		main_scene.add_child.call_deferred(bullet)
		animation_player.play("shoot")
		fire_rate_timer.start()
