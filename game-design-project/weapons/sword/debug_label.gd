extends Label

@onready var sword = $".."
@onready var sprite = $"../pivot/Sprite2D"

func _process(delta):
	text = "speed: " + str(sword.swing_rate) + "\nsize: " +str(sword.collision_shape.shape.size) + "\nscale: " + str(sprite.scale) 
	
	
