extends Base_Upgrade_Button

@onready var auto_pistol = get_tree().root.get_child(0).get_node("rectangle_guy/player_weapons/auto_pistol")
@onready var level_1 = $level_1
@onready var level_2 = $level_2
@onready var level_3 = $level_3

static var level : int = 0

func _ready():
	if level == 1:
		level_1.button_pressed = true
	if level == 2:
		level_1.button_pressed = true
		level_2.button_pressed = true
		
func _on_button_up():
	level += 1
	auto_pistol.res.accuracy += 0.1
	if level == 3:
		remove_upgrade("pistol_accuracy")
		print("removed pistol accuracy upgrade") 
	close()

func _on_mouse_entered():
	if level == 0:
		level_1.button_pressed = true
	if level == 1:
		level_2.button_pressed = true
	if level == 2:
		level_3.button_pressed = true

func _on_mouse_exited():
	if level == 0:
		level_1.button_pressed = false
	if level == 1:
		level_2.button_pressed = false
	if level == 2:
		level_3.button_pressed = false
