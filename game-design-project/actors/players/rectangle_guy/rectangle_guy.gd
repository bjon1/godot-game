extends Base_Player
class_name Rectangle_Guy

var xp : int = 0
var score : int = 0
var level_up_value : int = 300
var xp_level : int = 0
var is_paused : bool = false

@onready var boss_spawn_sound : AudioStreamPlayer2D = $sfx/boss_spawn_sound
@onready var game_over_sound : AudioStreamPlayer2D = $sfx/game_over_sound
@onready var upgrade_sound : AudioStreamPlayer2D = $sfx/upgrade_sound
@onready var level_up_sound : AudioStreamPlayer2D = $sfx/level_up_sound
@onready var xp_sound : AudioStreamPlayer2D = $sfx/xp_sound
@onready var pickup_area= $PickupArea/CollisionShape2D
@onready var player_weapons = $player_weapons
@onready var upgrade_menu = $CanvasLayer/UpgradeMenu
@onready var new_weapon_menu = $CanvasLayer/NewWeaponMenu

func collect_xp(value: int) -> void:
	xp_sound.pitch_scale = randf_range(0.8, 1.2)
	xp_sound.play()
	xp += value
	score += value
	if xp >= level_up_value:
		level_up_sound.play()
		xp = 0
		xp_level += 1
		level_up_value += 20
		if xp_level == 5:
			if not is_paused:
				new_weapon_menu.enable()
				Engine.time_scale = 0
				is_paused = true
		else:
			if not is_paused:
				upgrade_menu.enable()
				Engine.time_scale = 0
				is_paused = true
				
func upgrade_pickup_area(value: float) -> void:
	pickup_area.shape.radius += (1 + value)
	
func destroy():
	if health <= 0 :
		game_over_sound.play()
		var game_over_screen = preload("res://components/game_over_screen/game_over_screen.tscn")
		var game_over_scene = game_over_screen.instantiate()
		add_child(game_over_scene)
		Engine.time_scale = 0
		
func play_upgrade_sound():
	if upgrade_sound.is_inside_tree():
		upgrade_sound.play()
	
func play_boss_spawn_sound():
	if upgrade_sound.is_inside_tree():
		boss_spawn_sound.play()
#func _input(event):
	#if Input.is_action_just_pressed("reload"):
		#if Engine.time_scale == 0:
			#Engine.time_scale = 1
		#elif Engine.time_scale == 1:
			#Engine.time_scale = 0
