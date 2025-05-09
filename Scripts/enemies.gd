extends Node2D

class_name Enemy

var grid
var sprite
var player
var origin
var current_frame = 0
var active = false
var grid_pos = Vector2(-100, -100)
#active should always be set to true upon instantiating a new enemy
#grid_pos should always be set to something valid upon instantiating a new enemy

func _ready():
	#get nodes for reference
	origin = get_node("..")
	grid = get_node("../BattleGrid")
	player = get_node("../Player")
	sprite = $Sprite
	
	if active:
		#link to origin signals
		origin.enemy_move.connect(_on_enemy_move)
		update_pos()


func _on_enemy_move():
	beat_step()


func beat_step():
	frame_advance()
	update_pos()


func frame_advance():
	#default 2-frame animation behavior
	current_frame = (current_frame + 1) % 2
	sprite.frame = current_frame


func update_pos():
	#default repositioning behavior
	position = grid.to_global(grid.map_to_local(Vector2(grid_pos[0], grid_pos[1])))
