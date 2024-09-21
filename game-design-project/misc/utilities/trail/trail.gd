extends Line2D
class_name Trals

var queue : Array
@export var MAX_LENGTH : int = 25

func _process(delta: float) -> void:
	queue.push_front(_get_position())
	if queue.size() > MAX_LENGTH:
		queue.pop_back()
	clear_points()
	for point in queue:
		add_point(point)

func _get_position():
	return get_parent().global_position
