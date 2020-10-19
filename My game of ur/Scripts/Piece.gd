extends AnimatedSprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var tile_number:int
var size = 100
export var player : bool
var black_path = range(5)+range(9, 19)+[22]
var white_path = [-1]+range(5, 17)+range(19,22)
var animating = false
var dest:Vector2
var backing = false
# Called when the node enters the scene tree for the first time.
func _ready():
	if player:
		add_to_group("black")
		tile_number = 0
	else:
		add_to_group("white")
		tile_number = -1
	update_pos()
	if player:
		play("Black")
	else:
		play("White")


func move(num:int, animate = true)->bool:
	if player:
		if is_legal(num):
			tile_number = black_path[black_path.find(tile_number)+num]
			if tile_number == 22:
				remove_from_group('black')
			for i in get_tree().get_nodes_in_group('white'):
				if i.tile_number == tile_number:
					i.back()
		else:
			return false
		if animation == "Black":
			play("BlackDot")
			get_parent().black_stack.remove(0)
	else:
		if is_legal(num):
			tile_number = white_path[white_path.find(tile_number)+num]
			if tile_number == 21:
				remove_from_group('white')
			for i in get_tree().get_nodes_in_group('black'):
				if i.tile_number == tile_number:
					i.back()
		else:
			return false
		if animation == "White":
			play("WhiteDot")
			get_parent().white_stack.remove(0)
	if animate:
		animating = true
		if 0<=tile_number and tile_number<=4:
			dest = Vector2(5*size-tile_number*size+size/2, 3*size/2)
		elif tile_number==-1:
			dest = Vector2(5*size+size/2, 7*size/2)
		elif tile_number==22:
			dest = Vector2(6*size+size/2, 3*size/2)
		elif 5<=tile_number and tile_number<=8:
			dest = Vector2(5*size-(tile_number-4)*size+size/2, 7*size/2)
		elif 9<=tile_number and tile_number<=16:
			dest = Vector2((tile_number-8)*size+size/2, 5*size/2)
		elif 17<=tile_number and tile_number<=18:
			dest = Vector2(9*size-(tile_number-16)*size+size/2, 3*size/2)
		elif 19<=tile_number and tile_number<=21:
			dest = Vector2(9*size-(tile_number-18)*size+size/2, 7*size/2)
	else:
		update_pos()
	return true
func is_legal(num)->bool:
	if player:
		
		if black_path.find(tile_number)+num>=len(black_path)-1:
			if black_path.find(tile_number)+num>len(black_path)-1:
				return false
			
		else:
			if black_path[black_path.find(tile_number)+num] == 12:
				for i in get_tree().get_nodes_in_group('white'):
					if i.tile_number == 12:
						return false
			for i in get_tree().get_nodes_in_group('black'):
				if i.tile_number == black_path[black_path.find(tile_number)+num]:
					return false
	else:
		
		if white_path.find(tile_number)+num>=len(white_path)-1:
			if white_path.find(tile_number)+num>len(white_path)-1:
				return false
		else:
			if white_path[white_path.find(tile_number)+num] == 12:
				for i in get_tree().get_nodes_in_group('black'):
					if i.tile_number == 12:
						return false
			for i in get_tree().get_nodes_in_group('white'):
				if i.tile_number == white_path[white_path.find(tile_number)+num]:
					return false
			
	return true
func _process(delta):
	if backing:
		var pos
		if player:
			pos = Vector2(5*size+size/2, 3*size/2)
		else:
			pos = Vector2(5*size+size/2, 7*size/2)
		global_position = (pos-global_position)/5.0+global_position
		if abs(global_position.x-pos.x+global_position.y-pos.y)<0.01:
			backing = false
	if animating:
		global_position = (dest-global_position)/10.0+global_position
		if abs(global_position.x-dest.x)+abs(global_position.y-dest.y)<0.01:
			animating = false

func update_pos():
	if 0<=tile_number and tile_number<=4:
		global_position = Vector2(5*size-tile_number*size+size/2, 3*size/2)
	elif tile_number==-1:
		global_position = Vector2(5*size+size/2, 7*size/2)
	elif tile_number==22:
		global_position = Vector2(6*size+size/2, 3*size/2)
	elif 5<=tile_number and tile_number<=8:
		global_position = Vector2(5*size-(tile_number-4)*size+size/2, 7*size/2)
	elif 9<=tile_number and tile_number<=16:
		global_position = Vector2((tile_number-8)*size+size/2, 5*size/2)
	elif 17<=tile_number and tile_number<=18:
		global_position = Vector2(9*size-(tile_number-16)*size+size/2, 3*size/2)
	elif 19<=tile_number and tile_number<=21:
		global_position = Vector2(9*size-(tile_number-18)*size+size/2, 7*size/2)
func back():
	backing = true
	if player:
		tile_number = black_path[0]
		get_parent().black_stack.append(self)
		play("Black")
	else:
		tile_number = white_path[0]
		play("White")
		get_parent().white_stack.append(self)
