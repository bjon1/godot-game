extends Base_Pistol_Button

static var level : int = 0
@onready var level_1 = $level_1
@onready var level_2 = $level_2
@onready var level_3 = $level_3
@onready var level_4 = $level_4

func _ready():
	if level == 1:
		level_1.button_pressed = true
	if level == 2:
		level_1.button_pressed = true
		level_2.button_pressed = true
	if level == 3:
		level_1.button_pressed = true
		level_2.button_pressed = true
		level_3.button_pressed = true
		
func _on_button_up():
	level += 1
	auto_pistol.res.reload_speed -= 0.2
	if level == 4:
		remove_upgrade("pistol_reload_speed")
	close()

func _on_mouse_entered():
	if level == 0:
		level_1.button_pressed = true
	if level == 1:
		level_2.button_pressed = true
	if level == 2:
		level_3.button_pressed = true
	if level == 3:
		level_4.button_pressed = true

func _on_mouse_exited():
	if level == 0:
		level_1.button_pressed = false
	if level == 1:
		level_2.button_pressed = false
	if level == 2:
		level_3.button_pressed = false
	if level == 3:
		level_4.button_pressed = false
