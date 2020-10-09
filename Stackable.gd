extends Node2D

var stack : Array

func _ready():
	pass # Replace with function body.

func add(piece : Node2D):
	if(stack.size() == 0):
		stack.append(piece)
	else:
		stack[stack.size()-1].unselectable()
		stack.append(piece)
	return stack.size()-1

func removeTop():
	stack[stack.size()-2].selectable()
	return stack.pop_back()
