extends TileMapLayer

@export var warnings = {}

var corners = []
var dancefloor = true
var dancestep = false

func _ready():
	for y in range(5):
		var row = []
		row.resize(9)
		for x in range(9):
			var center = to_global(map_to_local(Vector2i(x, y)))
			var corner = Vector2(center.x - 46.54688, center.y - 42.85455) #Offsets from center to corner were calculated by trial and error. They work so I am NOT touching them anymore
			row[x] = corner
		corners.append_array(row)
	print(corners)
	material.set_shader_parameter("bpm", LevelVars.bpm)
	material.set_shader_parameter("corners", corners)

func _on_grid_update():
	for x in range(8):
		for y in range(4):
			$WarnGrid.set_cell(Vector2i(x, y), -1)
	
	for pos in warnings:
		$WarnGrid.set_cell(pos, 0, Vector2i(0, 0))
	warnings = {}
	
	dancestep = !dancestep
	material.set_shader_parameter("dancestep", dancestep)
