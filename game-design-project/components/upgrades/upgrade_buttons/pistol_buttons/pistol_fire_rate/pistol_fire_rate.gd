extends Base_Pistol_Button


func _on_button_up():
	auto_pistol.res.fire_rate -= 0.01
	close()