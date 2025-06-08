extends Node2D

class_name Entity

var grid
var sprite
var player
var origin
var current_frame = 0
var active = false
@export var grid_pos = Vector2i(-100, -100)
#active should always be set to true upon instantiating a new entity
#grid_pos should always be set to something valid upon instantiating a new entity


func _ready():
	#get nodes for reference
	origin = get_node("..")
	grid = get_node("../BattleGrid")
	player = get_node("../Player")
	sprite = $Sprite


func beat_step():
	frame_advance()
	update_pos()


func frame_advance():
	#default 2-frame animation behavior
	current_frame = (current_frame + 1) % 2
	sprite.frame = current_frame


func frame_set(new):
	current_frame = new
	sprite.frame = current_frame


func update_pos():
	position = grid.to_global(grid.map_to_local(Vector2i(grid_pos[0], grid_pos[1])))


func warn_pos(pos: Vector2i):
	grid.warnings[pos] = 0


func warn():
	pass #exists to be overwritten
