extends Base_Upgrade_Button


func _on_button_up():
	player.upgrade_pickup_area(20.0)
	close()
