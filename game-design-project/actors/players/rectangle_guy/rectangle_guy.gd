extends Base_Player
class_name Rectangle_Guy

var xp : int = 0
var level_up_value : int = 100
var xp_level : int = 0

@onready var xp_sound : AudioStreamPlayer2D = $sfx/xp_sound

func collect_xp(value: int) -> void:
	xp_sound.pitch_scale = randf_range(0.8, 1.2)
	xp_sound.play()
	xp += value
	if xp >= level_up_value:
		xp = 0
		xp_level += 1
		level_up_value += 10
	
