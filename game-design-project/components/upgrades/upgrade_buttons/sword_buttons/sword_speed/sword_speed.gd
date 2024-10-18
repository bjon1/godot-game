extends Base_Sword_Button
static var level : int = 0


func _on_button_up():
	level += 1
	sword.upgrade_speed(0.25)
	if level == 2:
		# Accesses upgrade_menu.gd
		remove_upgrade("sword_speed")
		print("removed: sword_speed")
	close()
