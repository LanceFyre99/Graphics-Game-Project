extends Timer

var beatnum = 0

func _ready():
	wait_time = 60.0 / LevelVars.bpm
	start()

func _on_timeout():
	beatnum += 1
	if beatnum <= 4:
		$Metronome.play()
	if beatnum == 5:
		$Metronome.queue_free()
		$BGM.play()
