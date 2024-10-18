extends Base_Player_Button


func _on_button_up():
	player.max_health += 50
	close()
