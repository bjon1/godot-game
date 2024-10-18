extends Base_Pistol_Button


func _on_button_up():
	auto_pistol.res.ammo_reserve += 300
	auto_pistol.res.ammo_ammount += auto_pistol.res.magazine_size
	close()
