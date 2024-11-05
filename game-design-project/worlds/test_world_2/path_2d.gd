extends Path2D

const FOLLOW_ENEMY = preload("res://actors/enemies/follow enemy/follow_enemy.tscn")
const BOSS_ENEMY  = preload("res://actors/enemies/boss_enemy/boss_enemy.tscn")

@onready var MAIN_SCENE = get_tree().root.get_child(0)
@onready var player : Rectangle_Guy = get_tree().root.get_child(0).get_node("rectangle_guy")

var changed_level : bool = false

func spawn_mob():
	var new_mob = FOLLOW_ENEMY.instantiate()
	%PathFollow2D.progress_ratio = randf()
	new_mob.global_position = %PathFollow2D.global_position
	MAIN_SCENE.add_child(new_mob)
	if (player.xp_level % 10 == 0) && !changed_level && player.xp_level != 0:
		changed_level = true
		var new_boss = BOSS_ENEMY.instantiate()
		%PathFollow2D.progress_ratio = randf()
		new_boss.global_position = %PathFollow2D.global_position
		MAIN_SCENE.add_child(new_boss)
		player.play_boss_spawn_sound()
	if (player.xp_level % 10 != 0):
		changed_level = false


func _on_spawn_timer_timeout():
	spawn_mob()
