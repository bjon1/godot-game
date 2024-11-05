extends Base_Player_Button


func _on_button_up():
	player.speed += 50
	close()
