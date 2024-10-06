extends Control

@onready var experience_bar : ProgressBar = $ExperienceBar
@onready var health_bar : ProgressBar = $HealthBar
@onready var xp_level : Label = $xp_level
@onready var rectangle_guy : Rectangle_Guy = $"../.."

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	health_bar.value = rectangle_guy.health
	experience_bar.max_value = rectangle_guy.level_up_value
	experience_bar.value = rectangle_guy.xp
	xp_level.text = str(rectangle_guy.xp_level)
	
