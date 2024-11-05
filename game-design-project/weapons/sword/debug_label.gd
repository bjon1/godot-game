extends Label

@onready var sword = $".."
@onready var sprite = $"../pivot/Sprite2D"

func _process(delta):
	text = "speed: " + str(sword.swing_rate) + "\nscale: " + str(sprite.scale) 
	
	
