extends Node2D

var rng = RandomNumberGenerator.new()
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export(String, FILE) var marked
export(String, FILE) var unmarked
# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	for i in range(1, 5):
		var text = "Die"+str(i)
		get_node(text).position = Vector2(i*100-50, 50)
		get_node(text).set_texture(load(marked))
func roll():
	var steps = 0
	for i in range(1, 5):
		var text = "Die"+str(i)
		var chance = rng.randf()
#		get_node(text).rotation = rng.randi_range(1, 3)*2*PI/3
#		if get_node(text).rotation==0:
#			get_node(text).position = Vector2(i*100-45, 50)
#
#		elif get_node(text).rotation>180:
#			get_node(text).position = Vector2(i*100-56, 89)
#		else:
#
#			get_node(text).position = Vector2(i*100-39, 75)
		
		if chance>0.50:
			get_node(text).set_texture(load(unmarked))
		else:
			get_node(text).set_texture(load(marked))
			steps+=1
	return steps

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
