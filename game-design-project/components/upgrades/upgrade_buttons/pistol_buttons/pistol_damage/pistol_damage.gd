extends Base_Pistol_Button


func _on_button_up():
	auto_pistol.res.damage += 10
	close()
