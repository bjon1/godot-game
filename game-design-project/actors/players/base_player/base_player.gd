extends Base_Character
class_name Base_Player

'''
Note:
	World exists on collision and mask layer 1
	Players exist on collision and mask layer 2
	Enemies exist on collision and mask layer 3
'''

enum {UP, DOWN}
@onready var weapons : Node2D = get_node("player_weapons")
var current_weapon : Node2D

# Knockback variables
var knockback_velocity = Vector2.ZERO
var knockback_friction = 0.9 # Controls how quickly knockback dissipates

func _ready() -> void:
	if weapons.get_child(0):
		for child in weapons.get_children():
			child.hide()
			child.set_process(false)
		current_weapon = weapons.get_child(0)
		current_weapon.show()
		current_weapon.set_process(true)

func _physics_process(_delta: float) -> void:
	# Handle player movement
	var direction : float = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
	
	direction = Input.get_axis("move_up", "move_down")
	if direction:
		velocity.y = direction * speed
	else:
		velocity.y = move_toward(velocity.y, 0, speed)
		
	# Apply knockback if present
	if knockback_velocity.length() > 0.1:
		velocity += knockback_velocity
		knockback_velocity *= knockback_friction  # Apply friction to reduce knockback over time
	
	# Weapon select
	if Input.is_action_just_pressed("scroll_up"):
		_switch_weapon(UP)
	if Input.is_action_just_pressed("scroll_down"):
		_switch_weapon(DOWN)
	if Input.is_action_just_pressed("slot_1"):
		select_weapon(0)
	if Input.is_action_just_pressed("slot_2"):
		select_weapon(1)
	
	move_and_slide()

func _switch_weapon(direction : int) -> void:
	var index : int = current_weapon.get_index()
	if direction == UP:
		index -= 1
		if index < 0:
			index = weapons.get_child_count() - 1
	else:
		index += 1
		if index > weapons.get_child_count() - 1:
			index = 0
			
	select_weapon(index)

func select_weapon(slot : int) -> void:
	if slot <= weapons.get_child_count() - 1:
		current_weapon.hide()
		current_weapon.set_process(false)
		current_weapon = weapons.get_child(slot)
		current_weapon.set_process(true)
		current_weapon.show() 

# Apply knockback to the player in a specific direction
func apply_knockback(direction: Vector2, knockback_value: float) -> void:
	knockback_velocity = direction * knockback_value
