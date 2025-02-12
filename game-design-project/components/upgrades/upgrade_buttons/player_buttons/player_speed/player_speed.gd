extends Base_Upgrade_Button


func _on_button_up():
	player.speed += 50
	close()
