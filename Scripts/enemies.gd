extends "res://Scripts/entities.gd"

class_name Enemy

func _ready():
	#call base _ready() to prep variables
	super()

	if active:
		#link to origin signals
		origin.enemy_move.connect(_on_enemy_move)
		update_pos()


func _on_enemy_move():
	beat_step()
