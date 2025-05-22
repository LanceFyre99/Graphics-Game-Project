extends Node2D

@export var bert_scene: PackedScene

var attack_list = 0
var templist

signal attack_move
signal enemy_move

func _ready():
	spawn_bert()


func _on_player_move():
	attack_move.emit()
	enemy_move.emit()


func _on_attack_move():
	#make sure all attacks have moved
	#after all have moved, send signals for enemies to move
	attack_list -= 1
	if attack_list <= 0:
		enemy_move.emit()


func spawn_bert():
	var bert = bert_scene.instantiate()
	
	bert.grid_pos = Vector2(5, 1)
	bert.active = true
	
	add_child(bert)
