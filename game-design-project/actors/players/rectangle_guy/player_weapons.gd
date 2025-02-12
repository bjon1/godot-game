extends Node2D

@onready var rectangle_guy : CharacterBody2D = $".."
var deadzone : float = 0.02

func _physics_process(delta):
	var global_mouse_position : Vector2 = get_global_mouse_position()
		# Get joystick input (assuming a gamepad)
	var joystick_input : Vector2 = Vector2(Input.get_axis("look_left", "look_right"), Input.get_axis("look_up", "look_down"))
	var rotation_angle : float = joystick_input.angle()  # angle in radians

	var movement_offset : Vector2 = rectangle_guy.velocity * (delta)
	
	# If joystick input exceeds the deadzone, calculate the direction based on joystick input
	if joystick_input.length() > deadzone:
		# Normalize the joystick input to get the direction
		var direction : Vector2 = joystick_input
		# Aim in the direction of the joystick
		self.rotation = rotation_angle  # Multiplied by a scalar to visualize a larger aim direction (optional)
	else:
		# If no joystick input, aim at the mouse position
		look_at(global_mouse_position + movement_offset)
