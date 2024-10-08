extends Area2D
class_name DropItem

@onready var xp = $"."

@export var xp_value : int = 10

var speed : int = 600
var player_location : Vector2 

func _ready():
	set_physics_process(false)

func _physics_process(delta):
	var direction = (player_location - position).normalized()
	position += direction * speed * delta
	
func _on_area_entered(area : Area2D) -> void:
	set_physics_process(true)
	player_location = area.global_position


func _on_body_entered(body):
	if body.has_method("collect_xp"):
		body.collect_xp(xp_value)
	queue_free()
