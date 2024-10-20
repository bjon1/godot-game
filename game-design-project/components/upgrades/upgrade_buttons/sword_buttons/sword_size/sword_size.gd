extends Base_Sword_Button

func _on_button_up():
	sword.upgrade_size(0.25)
	close()
