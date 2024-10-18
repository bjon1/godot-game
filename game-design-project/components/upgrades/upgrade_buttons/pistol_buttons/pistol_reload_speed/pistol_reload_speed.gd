extends Base_Pistol_Button



func _on_button_up():
	auto_pistol.res.reload_speed -= 0.2
	close()
