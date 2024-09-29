extends Line2D

'''
when attached to a node, creates a trail behind the node following it
make sure to set the start and end color only through the export tab
or through script so that this scene doesn't impact all other instances
of the trail node
'''

var queue : Array

@export var MAX_LENGTH : int = 25
@export var gradient_start_color : Color = Color.BLACK
@export var gradient_end_color : Color = Color.WHITE

func _ready() -> void:
	set_gradient_point(0, gradient_start_color)
	set_gradient_point(1, gradient_end_color)
	
func _process(_delta: float) -> void:
	queue.push_front(_get_position())
	if queue.size() > MAX_LENGTH:
		queue.pop_back()
	clear_points()
	for point in queue:
		add_point(point)
		
func _get_position():
	return get_parent().global_position

func set_gradient_point(point : int, color : Color) -> void:
	'''"
	this method is for setting the color at the index of a point that has 
	already been created, by default, point 0 and 1 already exist, so setting
	a new color at those points is valid.
	
	example usage:
	set_gradient_point(1, Color.(0 , 1 , 0)) #Green at the end
	'''
	gradient.set_color(point, color)
	
func add_gradient_point(point : float, color : Color) -> void:
	'''
	this method is for creating a new point the gradient in an index that
	does not yet exist. Attempting to alter the color of an already existing
	index with this method will not work
	
	example usage:
	add_gradient_point(0.5, Color(0, 0, 1))  # Blue at the middle
	'''
	gradient.add_point(point, color)
