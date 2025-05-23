extends Node

var deck_file = ["res://Attacks/bert_bullet.tscn"]
var deck_list = []
var leng
var next_up = 0


func _ready():
	for i in deck_file:
		var new = Card.new()
		new.prep(i)
		deck_list.append(new)
	leng = deck_list.size()


func play_card(pos, origin):
	var firing = deck_list[next_up]
	firing.execute(pos, origin)
	next_up = (next_up + 1) % leng
