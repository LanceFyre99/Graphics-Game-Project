extends Node2D

@export var bert_scene: PackedScene

var attack_num = 0
var temp_attack_num = 0

signal attack_move
signal check_player_hit
signal enemy_move

func _ready():
	spawn_wave()


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
	check_player_hit.emit()
	enemy_move.emit()
	temp_attack_num = attack_num


func spawn_wave():
	var spawns = []
	var count = 1
	
	for i in range(4):
		if randi() % count == 0:
			spawns.append(true)
		else:
			spawns.append(false)
		count += 1
	print(spawns)
	for i in range(4):
		if spawns[i]:
			spawn_enemy(bert_scene, Vector2(i + 4, randi() % 4))


func spawn_enemy(package, pos):
	var new = package.instantiate()
	
	new.grid_pos = pos
	new.active = true
	
	add_child(new)
