extends CanvasLayer

@onready var score_label = $score_label
@onready var player : Rectangle_Guy = get_tree().root.get_child(0).get_node("rectangle_guy")

func _ready():
	score_label.text = "Score: " + str(player.score)
	
func _on_restart_button_button_up():
	Engine.time_scale = 1
	get_tree().change_scene_to_file("res://worlds/test_world_2/test_world_2.tscn")


func _on_quit_button_button_up():
	get_tree().quit()
