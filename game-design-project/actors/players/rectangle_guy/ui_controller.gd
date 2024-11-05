extends Control

@onready var experience_bar : ProgressBar = $ExperienceBar
@onready var health_bar : ProgressBar = $HealthBar
@onready var xp_level : Label = $xp_level
@onready var rectangle_guy : Rectangle_Guy = $"../.."
@onready var current_health = $health/current_health
@onready var max_health = $health/max_health
@onready var mag_size : Label = $ammo/ammo_ammount
@onready var reserve : Label = $ammo/reserve
@onready var player_weapons = $"../../player_weapons"
@onready var ammo = $ammo


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	weapon_check()
	health_bar.value = rectangle_guy.health
	health_bar.max_value = rectangle_guy.max_health
	experience_bar.max_value = rectangle_guy.level_up_value
	experience_bar.value = rectangle_guy.xp
	current_health.text = str(rectangle_guy.health)
	max_health.text = str(rectangle_guy.max_health)
	xp_level.text = str(rectangle_guy.xp_level)
	

func weapon_check():
	if player_weapons.has_node("auto_pistol"):
		if player_weapons.get_node("auto_pistol").visible:
			ammo.show()
			mag_size.text = str(player_weapons.get_node("auto_pistol").res.ammo_ammount)
			reserve.text = str(player_weapons.get_node("auto_pistol").res.ammo_reserve)
		else:
			ammo.hide()
