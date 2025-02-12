extends Base_Upgrade_Button

func _on_button_up():
	sword.damage += 10
	close()
