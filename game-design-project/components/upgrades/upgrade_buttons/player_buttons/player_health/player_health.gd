extends Base_Upgrade_Button

func _on_button_up():
	if (player.health + 50) > player.max_health:
		player.health = player.max_health
	else:
		player.health += 50
	close()
