extends Node2D

@export var bert_scene: PackedScene

var attack_num = 0
var temp_attack_num = 0

signal attack_move
signal enemy_move

func _ready():
	spawn_bert()


func _on_player_move():
	if attack_num <= 0:
		post_attack_movement()
	else:
		attack_move.emit()


func _on_attack_spawned():
	attack_num += 1


func _on_attack_despawned():
	attack_num -= 1


func _on_attack_move_ack():
	#make sure all attacks have moved
	#after all have moved, send signals for enemies to move
	temp_attack_num -= 1
	if temp_attack_num <= 0:
		post_attack_movement()


func post_attack_movement():
	enemy_move.emit()
	temp_attack_num = attack_num


func spawn_bert():
	var bert = bert_scene.instantiate()
	
	bert.grid_pos = Vector2(5, 1)
	bert.active = true
	
	add_child(bert)
