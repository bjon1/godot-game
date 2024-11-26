extends Camera2D

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed('arrow_up'):
		var zoom = get_zoom() - Vector2(0.25, 0.25)
		if zoom > Vector2(0,0):
			set_zoom(get_zoom() - Vector2(0.25, 0.25))
	if Input.is_action_just_pressed('arrow_down'): #and get_zoom() > Vector2.ONE:
		var zoom = get_zoom() + Vector2(0.25, 0.25)
		if zoom < Vector2(5,5):
			set_zoom(get_zoom() + Vector2(0.25, 0.25))
