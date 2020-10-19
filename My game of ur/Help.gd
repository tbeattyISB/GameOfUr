extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export(String, FILE) var home
export var speed:float
export var upperlimit:float
export var lowerlimit:float
# Called when the node enters the scene tree for the first time.
func _ready():
	$instructions.position.y=lowerlimit # Replace with function body.
func _process(delta):
	if Input.is_action_pressed("ScrollDown") and $instructions.position.y>upperlimit:
		$instructions.position.y-=speed
	if Input.is_action_pressed("ScrollUp") and $instructions.position.y<lowerlimit:
		$instructions.position.y+=speed
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Back_button_up():
	get_tree().change_scene(home) # Replace with function body.
