extends Node2D

@onready var animation_player : AnimationPlayer = %AnimationPlayer
@onready var collision_shape : CollisionShape2D = %CollisionShape2D


@export_range(1.0, 5.0) var swing_rate : float = 1.0
@export_range(1.0, 2.5) var sword_size : float = 1.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("left_click"):
		swing()
	if Input.is_action_just_pressed("reload"):
		upgrade_speed(.25)
		upgrade_size(.25)


func swing():
	animation_player.play("swing")
	
func upgrade_speed(value: float):
	value = clamp(value, 0.0, 1.0)
	swing_rate = swing_rate * (1 + value)
	swing_rate = clamp(swing_rate, 1.0, 5.0)
	# Set the speed_scale of the AnimationPlayer
	animation_player.speed_scale = swing_rate
	
func upgrade_size(value: float):
	value = clamp(value, 0.0, 1.0)
	sword_size = sword_size * (1 + value)
	sword_size = clamp(sword_size, 1.0, 5.0)
	scale = Vector2(sword_size,sword_size)
