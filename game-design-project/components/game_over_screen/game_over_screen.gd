extends CanvasLayer


func _on_restart_button_button_up():
	Engine.time_scale = 1
	get_tree().change_scene_to_file("res://worlds/test_world_2/test_world_2.tscn")


func _on_quit_button_button_up():
	get_tree().quit()
