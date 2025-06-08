extends Area2D

var origin
var grid
var sprite
var deck
var dodging = false
var current_frame = 0
@export var grid_pos = Vector2i(1, 1)

signal move(action: String)

func _ready():
	origin = get_node("..")
	grid = get_node("../BattleGrid")
	sprite = $PlayerSprite
	deck = $Deck
	update_pos()


func _process(_delta):
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
	
	if Input.is_action_just_pressed("deck_call"):
		move.emit()
		deck.play_card(grid_pos, origin)
	
	if Input.is_action_just_pressed("dodge"):
		if dodging:
			beat_step()
		else:
			dodge()


func _on_damaged(damage):
	if dodging:
		print("Dodged!")
	else:
		print("Ow! You took " + str(damage) + " damage!")


func beat_step():
	if dodging:
		undodge()
	frame_advance()
	update_pos()
	move.emit()


func frame_advance():
	current_frame = (current_frame + 1) % 2
	sprite.frame = current_frame


func update_pos():
	position = grid.to_global(grid.map_to_local(Vector2i(grid_pos[0], grid_pos[1])))


func dodge():
	rotation_degrees -= 15
	sprite.material.set_shader_parameter("active", true)
	dodging = true
	move.emit()


func undodge():
	rotation_degrees = 0
	sprite.material.set_shader_parameter("active", false)
	dodging = false


func edge():
	print("bunp")
