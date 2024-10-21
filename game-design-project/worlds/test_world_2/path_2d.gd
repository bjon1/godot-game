extends Path2D

const FOLLOW_ENEMY = preload("res://actors/enemies/follow enemy/follow_enemy.tscn")
@onready var MAIN_SCENE = get_tree().root.get_child(0)

func spawn_mob():
	var new_mob = FOLLOW_ENEMY.instantiate()
	%PathFollow2D.progress_ratio = randf()
	new_mob.global_position = %PathFollow2D.global_position
	MAIN_SCENE.add_child(new_mob)


func _on_spawn_timer_timeout():
	spawn_mob()
