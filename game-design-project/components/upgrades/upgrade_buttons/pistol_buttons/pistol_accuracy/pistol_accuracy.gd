extends Base_Pistol_Button

static var level : int = 0

func _on_button_up():
	level += 1
	auto_pistol.res.accuracy += 0.1
	if auto_pistol.res.accuracy == 1.0:
		remove_upgrade("pistol_accuracy") 
	close()
