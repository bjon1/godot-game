extends Base_Player

#TODO import animationplayer to change animation based on movement
@onready var animation_player : AnimationPlayer = get_node("Rectangle_Guy").get_node("AnimationPlayer")

func _process(delta):
	super(delta)
	if velocity == Vector2.ZERO:
		animation_player.play("idle")
	else:
		animation_player.play("walk")
