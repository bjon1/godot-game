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
		else:
			upgrade_menu.enable()
		
func upgrade_pickup_area(value: float) -> void:
	pickup_area.shape.radius += (1 + value)
	
func open_upgrade_menu() -> void:
	pass
