extends Base_Player
class_name Rectangle_Guy

var xp : int = 0
var level_up_value : int = 100
var xp_level : int = 0

@onready var xp_sound : AudioStreamPlayer2D = $sfx/xp_sound
@onready var pickup_area= $PickupArea/CollisionShape2D
@onready var player_weapons = $player_weapons
@onready var upgrade_menu = $CanvasLayer/UpgradeMenu
@onready var new_weapon_menu = $CanvasLayer/NewWeaponMenu

func collect_xp(value: int) -> void:
	xp_sound.pitch_scale = randf_range(0.8, 1.2)
	xp_sound.play()
	xp += value
	if xp >= level_up_value:
		xp = 0
		xp_level += 1
		level_up_value += 10
		if xp_level == 5:
			new_weapon_menu.enable()
			Engine.time_scale = 0
		else:
			upgrade_menu.enable()
			Engine.time_scale = 0
			
		
func upgrade_pickup_area(value: float) -> void:
	pickup_area.shape.radius += (1 + value)
	
func open_upgrade_menu() -> void:
	pass
	
func destroy():
	if health <= 0 :
		var game_over_screen = preload("res://components/game_over_screen/game_over_screen.tscn")
		var game_over_scene = game_over_screen.instantiate()
		add_child(game_over_scene)
		Engine.time_scale = 0
#func _input(event):
	#if Input.is_action_just_pressed("reload"):
		#collect_xp(10)