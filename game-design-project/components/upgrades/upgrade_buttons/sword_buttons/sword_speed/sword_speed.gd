extends Base_Upgrade_Button
static var level : int = 0

@onready var level_1 : CheckBox = $level_1
@onready var level_2 : CheckBox = $level_2

func _ready():
	if level == 1:
		level_1.button_pressed = true
	
func _on_button_up():
	level += 1
	sword.upgrade_speed(0.25)
	if level == 2:
		# Accesses upgrade_menu.gd
		remove_upgrade("sword_speed")
		print("removed: sword_speed")
	close()

func _on_mouse_entered():
	if level == 0:
		level_1.button_pressed = true
	if level == 1:
		level_2.button_pressed = true

func _on_mouse_exited():
	if level == 0:
		level_1.button_pressed = false
	if level == 1:
		level_2.button_pressed = false
