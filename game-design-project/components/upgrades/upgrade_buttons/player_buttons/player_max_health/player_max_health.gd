extends Base_Upgrade_Button


func _on_button_up():
	player.max_health += 50
	close()
