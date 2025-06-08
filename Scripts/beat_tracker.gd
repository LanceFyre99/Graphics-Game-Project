extends Node2D

var rect = load("res://Level/crappy_beat_rect.tscn")
var bpm_timer

func _ready():
	bpm_timer = get_node("../BPMTimer")
	print(bpm_timer)

func _on_bpm_tracker_timeout():
	var left_rect = rect.instantiate()
	var right_rect = rect.instantiate()
	
	left_rect.position.x = -320
	right_rect.position.x = 320
	
	left_rect.direction = 1
	right_rect.direction = -1
	
	bpm_timer.timeout.connect(left_rect._on_timeout)
	bpm_timer.timeout.connect(right_rect._on_timeout)
	
	add_child(left_rect)
	add_child(right_rect)
