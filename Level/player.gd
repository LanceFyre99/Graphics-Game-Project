extends Area2D

var grid
var sprite
var current_frame = 0
var grid_pos = Vector2(1, 1)

func _ready():
	grid = get_node("../BattleGrid")
	sprite = $PlayerSprite
	update_pos()


func _process(delta):
	if Input.is_action_just_pressed("move_left"):
		if(grid_pos[0] > 0):
			grid_pos[0] -= 1
			beat_step()
		else:
			edge()


	if Input.is_action_just_pressed("move_right"):
		if(grid_pos[0] < 3):
			grid_pos[0] += 1
			beat_step()
		else:
			edge()

	if Input.is_action_just_pressed("move_up"):
		if(grid_pos[1] > 0):
			grid_pos[1] -= 1
			beat_step()
		else:
			edge()

	if Input.is_action_just_pressed("move_down"):
		if(grid_pos[1] < 3):
			grid_pos[1] += 1
			beat_step()
		else:
			edge()


func beat_step():
	frame_advance()
	update_pos()


func frame_advance():
	current_frame = (current_frame + 1) % 2
	sprite.frame = current_frame


func update_pos():
	position = grid.to_global(grid.map_to_local(Vector2(grid_pos[0] - 5, grid_pos[1] - 5)))

func edge():
	print("bunp")
