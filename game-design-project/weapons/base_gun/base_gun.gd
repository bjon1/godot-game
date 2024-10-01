@icon("res://assets/icons/pistol-gun.png")
extends Node2D
class_name Base_Gun

'''
@export var main_scene : Node2D
must be exported in order for bullet position
to not be affected by the weapon's position
after firing.
'''

@export var res : Gun_Resource
@onready var main_scene = get_tree().root.get_child(0)

##State Machine
enum states{IDLE, FIRING, RELOADING, CHARGING}
var current_state : states = states.IDLE

#Node initialization
@onready var animation_player : AnimationPlayer = $AnimationPlayer
@onready var barrel_position : Node2D = $barrel_position
@onready var reload_progress_bar : ProgressBar = $reload_progress_bar

#SFX initialization
@onready var gun_shot : AudioStreamPlayer2D = $sfx/gun_shot
@onready var no_ammo : AudioStreamPlayer2D = $sfx/no_ammo

#used to determine animation playback speed
@onready var reload_animation_length : float = animation_player.get_animation("reload").length
@onready var shoot_animation_length : float = animation_player.get_animation("shoot").length

#states
func _ready() -> void:
	add_child(res.fire_rate_timer)
	add_child(res.burst_delay_timer)
	add_child(res.reload_speed_timer)
	res.initialize()
	
func _process(_delta: float) -> void:
	get_input()

func get_input() -> void:
	'''
	this method should be called from the
	_process(delta: float) -> void: function
	in a different class
	'''	
	if current_state == states.IDLE:
		if Input.is_action_just_pressed("right_click"):
			print(global_position)
		if res.automatic_fire == true and Input.is_action_pressed("left_click"):
			_handle_firing_state()
		elif Input.is_action_just_pressed("left_click"):
			_handle_firing_state()
		if Input.is_action_just_pressed("reload"):
			_handle_reloading_state()
	elif current_state == states.RELOADING:
		if Input.is_action_just_pressed("reload"):
			_handle_reloading_state()

func _handle_firing_state():
	if res.has_ammo():
		shoot()

func _handle_reloading_state():
	if res.can_reload():
		reload()
	
func shoot() -> void:
	current_state = states.FIRING
	
	res.ammo_ammount -= 1
	var speed_scale : float = max((shoot_animation_length/res.fire_rate), 1)
	
	for i in res.bullet_count:
		animation_player.play("shoot", -1, speed_scale)
		gun_shot.play()
			
		#instantiate and add bullet to scene
		var bullet : Node = _create_bullet(i)
		main_scene.add_child.call_deferred(bullet)
			
		if res.bullet_count > 1 and res.has_burst_delay():
			res.burst_delay_timer.start()
			await res.burst_delay_timer.timeout
				
	if res.ammo_ammount == 0:
		animation_player.play("no_ammo")
		_handle_reloading_state()
	else:
		res.fire_rate_timer.start()
		await res.fire_rate_timer.timeout
		current_state = states.IDLE

func reload() -> void:
	reload_progress_bar.set_value(0)
	
	#Handles reload cancelation
	if current_state == states.RELOADING:
		if res.has_ammo():	#prevent reload cancelation if gun has no ammo
			current_state = states.IDLE
			res.reload_speed_timer.emit_signal("timeout")	#emit timeout to trigger reload await
			animation_player.stop()
	else:
		current_state = states.RELOADING
		
		var speed_scale : float = (reload_animation_length/res.reload_speed)
		animation_player.play("reload", -1, speed_scale)
		
		reload_progress_bar.show()
		var tween : Tween = create_tween()
		tween.tween_property(reload_progress_bar, "value", 100, res.reload_speed)
		
		res.reload_speed_timer.start(res.reload_speed)
		await res.reload_speed_timer.timeout
		
		tween.stop()
		
		if current_state == states.RELOADING: #Checks if reload has been canceled			
			res.reload_weapon()
			
		reload_progress_bar.hide()
		animation_player.queue("idle")
		current_state = states.IDLE
		
func _create_bullet(i : int) -> Node:
		#instantiate bullet
		var bullet = res.bullet_scene.instantiate()
		bullet.spawn_position = barrel_position.global_position
		bullet.spawn_rotation = _calculate_bullet_spread(i) + res.calculate_accuracy()
		bullet.res = res.get_bullet_resource()
		return bullet
		
func _calculate_bullet_spread(i : int) -> float:
	if res.bullet_count > 1:
		var increment = res.bullet_spread / (res.bullet_count - 1)
		return (global_rotation + increment * i - res.bullet_spread / 2)
	return global_rotation
