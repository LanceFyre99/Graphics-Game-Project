extends "res://Scripts/entities.gd"

class_name Attack

var damaging = 0

signal attack_spawned
signal attack_despawned
signal attack_move_ack
signal damaged(damage: int)

func _ready():
	#call base _ready() to prep variables
	super()

	if active:
		#link to origin signals
		origin.attack_move.connect(_on_attack_move)
		origin.check_player_hit.connect(_on_check_player_hit)
		attack_spawned.connect(origin._on_attack_spawned)
		attack_despawned.connect(origin._on_attack_despawned)
		attack_move_ack.connect(origin._on_attack_move_ack)
		damaged.connect(player._on_damaged)

		attack_spawned.emit()
		update_pos()


func _on_attack_move():
	beat_step()
	attack_move_ack.emit()


func _on_check_player_hit():
	if grid_pos == player.grid_pos:
		damaged.emit(damaging)
