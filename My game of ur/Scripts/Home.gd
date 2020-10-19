extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export(String, FILE) var game
export(String, FILE) var help
# Called when the node enters the scene tree for the first time.
func _ready():
	$HBoxContainer.rect_position = Vector2(500-$HBoxContainer.rect_size.x/2.0, 200) # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Quit_button_up():
	get_tree().quit() # Replace with function body.


func _on_Play_button_up():
	get_tree().change_scene(game) # Replace with function body.


func _on_Help_button_up():
	get_tree().change_scene(help) # Replace with function body.
