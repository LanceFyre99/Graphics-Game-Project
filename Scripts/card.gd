extends Node

class_name Card

var package


func prep(path):
	package = load(path)


func execute(pos, origin):
	var inst = package.instantiate()
	
	inst.position_self(pos)
	inst.active = true
	
	origin.add_child(inst)
