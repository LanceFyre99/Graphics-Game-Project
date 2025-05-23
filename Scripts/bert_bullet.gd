extends "res://Scripts/attacks.gd"

func position_self(parent_pos):
	grid_pos = Vector2(parent_pos[0] - 1, parent_pos[1])

func beat_step():
	grid_pos[0] -= 1
	if grid_pos[0] < 0:
		queue_free()
	update_pos()
