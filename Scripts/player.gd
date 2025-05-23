extends Area2D

var origin
var grid
var sprite
var deck
var dodging = false
var current_frame = 0
@export var grid_pos = Vector2(1, 1)

signal move(action: String)
signal damaged

func _ready():
	origin = get_node("..")
	grid = get_node("../BattleGrid")
	sprite = $PlayerSprite
	deck = $Deck
	origin.player_move_ack.connect(_on_player_move_ack)
	update_pos()


func _process(_delta):
	if Input.is_action_just_pressed("move_left"):
		move.emit("move_left")
	
	if Input.is_action_just_pressed("move_right"):
		move.emit("move_right")
	
	if Input.is_action_just_pressed("move_up"):
		move.emit("move_up")
	
	if Input.is_action_just_pressed("move_down"):
		move.emit("move_down")
	
	if Input.is_action_just_pressed("deck_call"):
		move.emit("deck_call")
	
	if Input.is_action_just_pressed("dodge"):
		move.emit("dodge")


func _on_player_move_ack(action):
	if action == "move_left":
		if(grid_pos[0] > 0):
			grid_pos[0] -= 1
			beat_step()
		else:
			edge()
	
	if action == "move_right":
		if(grid_pos[0] < 3):
			grid_pos[0] += 1
			beat_step()
		else:
			edge()
	
	if action == "move_up":
		if(grid_pos[1] > 0):
			grid_pos[1] -= 1
			beat_step()
		else:
			edge()
	
	if action == "move_down":
		if(grid_pos[1] < 3):
			grid_pos[1] += 1
			beat_step()
		else:
			edge()
	
	if action == "deck_call":
		print(deck)
		deck.play_card(grid_pos, origin)
		
	
	if action == "dodge":
		if dodging:
			beat_step()
		else:
			dodge()


func beat_step():
	if dodging:
		undodge()
	frame_advance()
	update_pos()


func frame_advance():
	current_frame = (current_frame + 1) % 2
	sprite.frame = current_frame


func update_pos():
	position = grid.to_global(grid.map_to_local(Vector2(grid_pos[0], grid_pos[1])))


func dodge():
	rotation_degrees -= 15
	sprite.material.set_shader_parameter("active", true)
	dodging = true


func undodge():
	rotation_degrees = 0
	sprite.material.set_shader_parameter("active", false)


func edge():
	print("bunp")
