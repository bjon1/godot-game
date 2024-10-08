extends Base_Player
class_name Rectangle_Guy

var xp : int = 0
var level_up_value : int = 100
var xp_level : int = 0

@onready var xp_sound : AudioStreamPlayer2D = $sfx/xp_sound
@onready var upgrade_menu_scene = preload("res://ui/upgrade_menu.tscn")
@onready var pickup_area= $PickupArea/CollisionShape2D
@onready var player_weapons = $player_weapons

func collect_xp(value: int) -> void:
	xp_sound.pitch_scale = randf_range(0.8, 1.2)
	xp_sound.play()
	xp += value
	if xp >= level_up_value:
		xp = 0
		xp_level += 1
		level_up_value += 10
		open_upgrade_menu()
		
func upgrade_pickup_area(value) -> void:
	pickup_area.shape.radius += (1 + value)
	
func open_upgrade_menu() -> void:
	set_process(false)
	current_weapon.set_process(false)
	var upgrade_menu = upgrade_menu_scene.instantiate()
	get_tree().current_scene.add_child(upgrade_menu)
