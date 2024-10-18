extends Button
class_name Base_Player_Button

@onready var player : Rectangle_Guy = get_tree().root.get_child(0).get_node("rectangle_guy")
var level : int
