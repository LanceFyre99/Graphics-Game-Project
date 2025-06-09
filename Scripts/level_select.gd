extends Control

var level_button

#I'll come up with a better way to store this data later, probably a csv or something
var song_titles = ["Throwing Fire"]
var artist_list = ["Ronald Jenkees"]
var song_paths = ["res://Audio/Songs/Throwing Fire.ogg"]
var bpm_list = [105]

func _ready():
	level_button = load("res://Level/level_select_button.tscn")
	for i in range(song_paths.size()):
		var new = level_button.instantiate()
		
		new.title = song_titles[i]
		new.artist = artist_list[i]
		new.audio_path = song_paths[i]
		new.bpm = bpm_list[i]
		
		$ScrollContainer/VBoxContainer.add_child(new)
