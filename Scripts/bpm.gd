extends Timer

var beatnum = 0
var halfway = false
var moved = false

signal timeout_no_move

func _ready():
	wait_time = 60.0 / LevelVars.bpm
	start()

func _process(delta):
	if time_left <= wait_time / 2 and not halfway:
		halfway = true
		if not moved:
			timeout_no_move.emit()
		else:
			moved = false

func _on_timeout():
	halfway = false
	beatnum += 1
	if beatnum <= 4:
		$Metronome.play()
	if beatnum == 5:
		$Metronome.queue_free()
		$BGM.play()
