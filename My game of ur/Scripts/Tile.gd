extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export(String, FILE) var image1
export(String, FILE) var image2
export(String, FILE) var image3
export(String, FILE) var image4
export(String, FILE) var image5
export(String, FILE) var image6
export var tile_number:int
# Called when the node enters the scene tree for the first time.
func _ready():
	var rect = get_viewport_rect()
	var size = rect.size.x/10
	
	if tile_number in [1, 3, 5, 7, 15]:
		set_texture(load(image5))
	elif tile_number in [2, 6, 10, 13, 16]:
		set_texture(load(image4))
	elif tile_number in [4, 8, 12, 18, 20]:
		set_texture(load(image6))
	elif tile_number ==9:
		set_texture(load(image2))
	elif tile_number in [11, 14]:
		set_texture(load(image1))
	else:
		set_texture(load(image3))
	if 1<=tile_number and tile_number<=4:
		global_position = Vector2(5*size-tile_number*size+size/2, 3*size/2)
	if 5<=tile_number and tile_number<=8:
		global_position = Vector2(5*size-(tile_number-4)*size+size/2, 7*size/2)
	elif 9<=tile_number and tile_number<=16:
		global_position = Vector2((tile_number-8)*size+size/2, 5*size/2)
	elif 17<=tile_number and tile_number<=18:
		global_position = Vector2(9*size-(tile_number-16)*size+size/2, 3*size/2)
	elif 19<=tile_number and tile_number<=20:
		global_position = Vector2(9*size-(tile_number-18)*size+size/2, 7*size/2)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
