extends Polygon2D

@export var direction = 0 #-1 is left, 1 is right
var metronome = 4
var speed
var fading = false

func _ready():
	speed = 80 / (60.0 / LevelVars.bpm) # number of pixels to travel per beat

func _process(delta):
	position.x += speed * direction * delta
	if fading:
		color.a -= 0.1
		if color.a <= 0:
			queue_free()

func _on_timeout():
	metronome -= 1
	if metronome <= 0:
		direction = 0
		fading = true
