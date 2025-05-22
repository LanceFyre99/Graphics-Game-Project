extends "res://Scripts/attacks.gd"

func beat_step():
	grid_pos[0] -= 1
	if grid_pos[0] < 0:
		queue_free()
	update_pos()
