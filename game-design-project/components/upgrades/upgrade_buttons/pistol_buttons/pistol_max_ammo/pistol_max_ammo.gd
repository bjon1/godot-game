extends Base_Pistol_Button


func _on_button_up():
	auto_pistol.res.ammo_reserve += 356
	auto_pistol.reload()
	close()
