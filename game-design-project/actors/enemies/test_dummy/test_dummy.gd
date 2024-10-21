extends Base_Enemy

@onready var label : Label = $damage_indicator

var damage_per_second = 0

func _ready() -> void:
	health = 1

func take_damage(damage_amount : float):
	damage_per_second += damage_amount
	#animation_player.play("hurt")
	#animation_player.queue("idle")
	label.set_text(str(damage_amount) + "dmg/" + str(damage_per_second) + "dps")

func _on_damage_per_second_timer_timeout() -> void:
	damage_per_second = 0
