extends Node2D
class_name Base_Sword

enum Target_Layers{
	Player,
	Enemy
}

@onready var animation_player : AnimationPlayer = %AnimationPlayer
@onready var hurt_box : Area2D = %Area2D
@onready var hit_sound : AudioStreamPlayer2D = $sfx/hit_sound


@export var swing_rate : float 
@export var sword_size : float 
@export var damage : int = 15
@export var weapon_target : Target_Layers = Target_Layers.Enemy

# Called when the node enters the scene tree for the first time.
func _ready():
	set_collision()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("left_click"):
		swing()


func swing():
	if Engine.time_scale != 0:
		animation_player.play("swing")
	
func upgrade_speed(value: float):
	swing_rate = swing_rate * (1 + value)
	# Set the speed_scale of the AnimationPlayer
	animation_player.speed_scale = swing_rate
	
func upgrade_size(value: float):
	sword_size = sword_size * (1 + value)
	scale = Vector2(sword_size,sword_size)
	
func _on_hurt_box_body_entered(body: Node2D) -> void:
	if body.has_method("take_damage"):
		body.take_damage(damage)
		hit_sound.play()
		
		
func set_collision():
	hurt_box.set_collision_mask_value(weapon_target + 2, true)
