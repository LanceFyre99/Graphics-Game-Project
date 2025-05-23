extends "res://Scripts/enemies.gd"

var shot_timer
var bullet
var moving_down = true

func _ready():
	#call base _ready() to prep variables
	super()
	
	bullet = load("res://Attacks/bert_bullet.tscn")
	shot_timer = randi() % 3 + 4


func beat_step():
	shot_timer -= 1
	if shot_timer == 0:
		frame_set(3)
		spawn_attack()
		shot_timer = randi() % 3 + 3
	elif shot_timer == 1:
		frame_set(2)
		#trigger warning box
	else:
		#movement logic
		if moving_down and grid_pos[1] >= 3:
			moving_down = false
		if not moving_down and grid_pos[1] <= 0:
			moving_down = true
		if moving_down:
			grid_pos[1] += 1
		else:
			grid_pos[1] -= 1
		
		frame_advance()
		update_pos()
	

func spawn_attack():
	var shot = bullet.instantiate()
	
	shot.position_self(grid_pos)
	shot.active = true
	
	origin.add_child(shot)
