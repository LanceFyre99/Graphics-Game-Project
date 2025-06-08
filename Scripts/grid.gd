extends TileMapLayer

@export var warnings = {}



func _on_grid_update() -> void:
	for x in range(8):
		for y in range(4):
			$WarnGrid.set_cell(Vector2i(x, y), -1)
	
	for pos in warnings:
		$WarnGrid.set_cell(pos, 0, Vector2i(0, 0))
	warnings = {}
