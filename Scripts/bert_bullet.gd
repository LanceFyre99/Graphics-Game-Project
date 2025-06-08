extends "res://Scripts/attacks.gd"


func position_self(parent_pos):
	grid_pos = Vector2i(parent_pos.x - 1, parent_pos.y)


func warn():
	warn_pos(Vector2i(grid_pos.x - 1, grid_pos.y))


func beat_step():
	grid_pos.x -= 1
	if grid_pos.x >= 1:
		warn()
	if grid_pos.x < 0:
		attack_despawned.emit()
		queue_free()
	update_pos()
