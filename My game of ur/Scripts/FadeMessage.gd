extends ColorRect


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	var colors = $Label.get("custom_colors/font_color")
	colors.a-=0.01
	
	color.a = colors.a
	$ColorRect.color.a = colors.a
	$Label.set("custom_colors/font_color", colors)
	if color.a<=0:
		queue_free()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
