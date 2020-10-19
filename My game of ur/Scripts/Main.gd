extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var rng = RandomNumberGenerator.new()
export(String, FILE) var tile
export(String, FILE) var piece
var white_stack = []
var black_stack = []
var turn = true
var moving = false
var step = 0
var normal : bool
export(String, FILE) var fade
export(String, FILE) var home
# Called when the node enters the scene tree for the first time.
func _ready():
	var size = 100
	$EndScreen/background.hide()
	$EndScreen/background/HBoxContainer.rect_position = Vector2(500, 250)-$EndScreen/background/HBoxContainer.rect_size/2.0
	$Dice.global_position = Vector2(100, 400)
	$White.rect_position = Vector2(5*size+size/2-5, 7*size/2-4)
	$Black.rect_position = Vector2(5*size+size/2-5, 3*size/2-4)
	tile = load(tile).instance()
	piece = load(piece).instance()
	rng.randomize()
	$DiceBorder/Bk.rect_size = Vector2(396, 96)
	$DiceBorder/Bk.rect_position = Vector2(102, 402)
	$DiceBorder/ColorRect.rect_size = Vector2(400, 100)
	$DiceBorder/ColorRect.rect_position = Vector2(100, 400)
	$BoardBorder/Bk.rect_size = Vector2(796+6, 296+6)
	$BoardBorder/Bk.rect_position = Vector2(102-3, 102-3)
	$BoardBorder/ColorRect.rect_size = Vector2(800+6, 300+6)
	$BoardBorder/ColorRect.rect_position = Vector2(100-3, 100-3)
	var last
	for i in range(1, 21):
		var temp = tile.duplicate()
		temp.tile_number = i
		add_child_below_node($BoardBorder, temp)
		if i ==1:
			last = temp
	for i in range(5):
		var p = piece.duplicate()
		p.player = false
		add_child_below_node(last, p)
		white_stack.append(p)
		p = piece.duplicate()
		p.player = true
		add_child_below_node(last, p)
		black_stack.append(p)
	var temp = load(fade).instance().duplicate()
	temp.rect_position = Vector2(500-temp.rect_size.x/2, 250-temp.rect_size.y/2)
	add_child(temp)
func _process(delta):
	if Input.is_action_just_pressed("click") and moving:
		
		var pos = get_viewport().get_mouse_position()
		if turn:
			for i in get_tree().get_nodes_in_group('black'):
				if (i.global_position.x-pos.x)*(i.global_position.x-pos.x)+(i.global_position.y-pos.y)*(i.global_position.y-pos.y)<=4900:
					var legal = i.move(step)
					if legal:
						if i.tile_number in [4, 8, 12, 18, 20]:
							var temp = load(fade).instance().duplicate()
							temp.get_node("Label").text = "Roll Again!"
							temp.rect_position = Vector2(500-temp.rect_size.x/2, 250-temp.rect_size.y/2)
							add_child(temp)
						else:
							if !normal:
								if i.tile_number in [10, 11]:
									i.move(2, true)
								elif i.tile_number in [14, 15]:
									i.move(-2, true)
								if i.tile_number in [4, 8, 12, 18, 20]:
									var temp = load(fade).instance().duplicate()
									temp.get_node("Label").text = "Roll Again!"
									temp.rect_position = Vector2(500-temp.rect_size.x/2, 250-temp.rect_size.y/2)
									add_child(temp)
									moving = false
									$DiceBorder.show()
									$BoardBorder.hide()
									return
							turn=!turn
							var temp = load(fade).instance().duplicate()
							temp.rect_position = Vector2(500-temp.rect_size.x/2, 250-temp.rect_size.y/2)
							add_child(temp)
						if len(get_tree().get_nodes_in_group("black"))==0:
							$EndScreen/background/Label.text = "Black Won"
							$EndScreen/background.show()
						moving = false
						$DiceBorder.show()
						$BoardBorder.hide()
					else:
						var temp = load(fade).instance().duplicate()
						temp.get_node("Label").text = "Illegal"
						temp.rect_position = Vector2(500-temp.rect_size.x/2, 250-temp.rect_size.y/2)
						add_child(temp)
						
					break
		else:
			for i in get_tree().get_nodes_in_group('white'):
				if (i.global_position.x-pos.x)*(i.global_position.x-pos.x)+(i.global_position.y-pos.y)*(i.global_position.y-pos.y)<=4900:
					var legal = i.move(step)
					if legal:
						if i.tile_number in [4, 8, 12, 18, 20]:
							var temp = load(fade).instance().duplicate()
							temp.get_node("Label").text = "Roll Again!"
							temp.rect_position = Vector2(500-temp.rect_size.x/2, 250-temp.rect_size.y/2)
							add_child(temp)
						else:
							if !normal:
								if i.tile_number in [10, 11]:
									i.move(2, true)
								elif i.tile_number in [14, 15]:
									i.move(-2, true)
								if i.tile_number in [4, 8, 12, 18, 20]:
									var temp = load(fade).instance().duplicate()
									temp.get_node("Label").text = "Roll Again!"
									temp.rect_position = Vector2(500-temp.rect_size.x/2, 250-temp.rect_size.y/2)
									add_child(temp)
									moving = false
									$DiceBorder.show()
									$BoardBorder.hide()
									return
									
							turn=!turn
							var temp = load(fade).instance().duplicate()
							temp.rect_position = Vector2(500-temp.rect_size.x/2, 250-temp.rect_size.y/2)
							add_child(temp)
						if len(get_tree().get_nodes_in_group("white"))==0:
							$EndScreen/background/Label.text = "White Won"
							$EndScreen/background.show()
						moving = false
						$DiceBorder.show()
						$BoardBorder.hide()
					else:
						var temp = load(fade).instance().duplicate()
						temp.get_node("Label").text = "Illegal"
						temp.rect_position = Vector2(500-temp.rect_size.x/2, 250-temp.rect_size.y/2)
						add_child(temp)
						
					break
	if Input.is_action_just_pressed("click") and !moving:
		var pos = get_viewport().get_mouse_position()
		if 100<pos.x and pos.x<500 and 400<pos.y and pos.y<500:
			step = $Dice.roll()
			if step==0:
				var temp = load(fade).instance().duplicate()
				temp.get_node("Label").text = "Skipped"
				temp.rect_position = Vector2(500-temp.rect_size.x/2, 250-temp.rect_size.y/2)
				add_child(temp)
				turn = !turn
			else:
				var has_legel = false
				if turn:
					for i in get_tree().get_nodes_in_group("black"):
						if i.is_legal(step):
							has_legel = true
							break
				else:
					for i in get_tree().get_nodes_in_group("white"):
						if i.is_legal(step):
							has_legel = true
							break
				if not has_legel:
					var temp = load(fade).instance().duplicate()
					temp.get_node("Label").text = "Skipped"
					temp.rect_position = Vector2(500-temp.rect_size.x/2, 250-temp.rect_size.y/2)
					add_child(temp)
					turn = !turn
				else:
					moving = true
					$DiceBorder.hide()
					$BoardBorder.show()

	if turn:
		$Turn.text = "Black's turn"
	else:
		$Turn.text = "White's turn"
	if len(white_stack)==0:
		$White.text = ''
	else:
		$White.text = str(len(white_stack))
	if len(black_stack)==0:
		$Black.text = ''
	else:
		$Black.text = str(len(black_stack))


func _on_PlayAgain_button_up():
	get_tree().reload_current_scene()


func _on_Home_button_up():
	get_tree().change_scene(home)


func _on_Menu_button_up():
	$EndScreen/Menu.hide()
	$EndScreen/Back.show()
	$EndScreen/background.show()


func _on_Back_button_up():
	$EndScreen/Menu.show()
	$EndScreen/Back.hide()
	$EndScreen/background.hide()


func _on_Normal_button_up():
	normal = true # Replace with function body.
	$EndScreen/ChooseMode.hide()


func _on_Other_button_up():
	normal = false # Replace with function body.
	$EndScreen/ChooseMode.hide()
