extends "res://Scripts/entities.gd"

class_name Attack

func _ready():
	#call base _ready() to prep variables
	super()

	if active:
		#link to origin signals
		origin.attack_move.connect(_on_attack_move)
		update_pos()


func _on_attack_move():
	beat_step()
