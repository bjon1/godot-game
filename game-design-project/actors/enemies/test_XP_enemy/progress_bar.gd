extends ProgressBar

@onready var test_xp_enemy = $".."

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	value = test_xp_enemy.health
	max_value = test_xp_enemy.max_health
