extends Base_Sword_Button
static var level : int = 0


func _on_button_up():
	level += 1
	sword.upgrade_speed(0.25)
	print(level)
	if level == 2:
		# Accesses upgrade_menu.gd
		get_parent().get_parent().upgrades_dict.erase("sword_speed")
	close()
