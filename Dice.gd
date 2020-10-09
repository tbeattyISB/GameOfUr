extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var diceVal = null

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _input_event(viewport, event, shape_idx):
	if(event.is_action_pressed('click')):
		diceVal = randi() % 6 + 1
		$Label.text = String(diceVal)
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
