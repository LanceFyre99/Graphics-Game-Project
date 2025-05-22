extends Area2D

var grid
var sprite
var current_frame = 0
@export var grid_pos = Vector2(1, 1)

signal move
signal damaged

func _ready():
	grid = get_node("../BattleGrid")
	sprite = $PlayerSprite
	update_pos()
	print(global_position)


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
			
	if Input.is_action_just_pressed("dodge"):
		dodge()


func beat_step():
	undodge()
	frame_advance()
	update_pos()
	move.emit()


func frame_advance():
	current_frame = (current_frame + 1) % 2
	sprite.frame = current_frame


func update_pos():
	position = grid.to_global(grid.map_to_local(Vector2(grid_pos[0], grid_pos[1])))


func dodge():
	rotation_degrees -= 15
	sprite.material.set_shader_parameter("active", true)
	move.emit()


func undodge():
	rotation_degrees = 0
	sprite.material.set_shader_parameter("active", false)


func edge():
	print("bunp")
