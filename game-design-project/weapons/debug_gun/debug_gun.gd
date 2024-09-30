extends Auto_Pistol

'''
@export var main_scene : Node2D
must be exported in order for bullet position
to not be affected by the weapon's position
after firing.
'''

var state_names : Array = ["IDLE", "FIRING", "RELOADING", "CHARGING"]
@onready var label = $debug_text

func _input(event: InputEvent) -> void:
	#program toolip codes
	pass
	
func _process(_delta: float) -> void:
	if label:
		label.set_text("ammo: " + str(res.ammo_ammount) +
		 "\nreserve: " + str(res.ammo_reserve) +
		"\nmag size: " + str(res.magazine_size) +
		"\nstate: " + state_names[current_state])
		
	get_input()
