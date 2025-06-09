extends Button

var title: String
var artist: String
var audio_path: String
var bpm: int

func _on_pressed():
	LevelVars.ost = audio_path
	LevelVars.bpm = bpm
	
	get_tree().change_scene_to_file("res://Level/Level.tscn")
