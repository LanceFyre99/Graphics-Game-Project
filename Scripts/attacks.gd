extends "res://Scripts/entities.gd"

class_name Attack

signal attack_spawned
signal attack_despawned
signal attack_move_ack

func _ready():
	#call base _ready() to prep variables
	super()

	if active:
		#link to origin signals
		origin.attack_move.connect(_on_attack_move)
		attack_spawned.connect(origin._on_attack_spawned)
		attack_despawned.connect(origin._on_attack_despawned)
		attack_move_ack.connect(origin._on_attack_move_ack)

		attack_spawned.emit()
		update_pos()


func _on_attack_move():
	beat_step()
	attack_move_ack.emit()
