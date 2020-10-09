extends Node

export var playerPieces := 5

const STATES = ["P1ROLE, P1PLAY, P1ANIMATE, P2ROLE, P2PLAY, P2ANIMATE"]

var player1Tiles : = []
var player2Tiles : = []
var player1Pieces : =  []
var player2Pieces : = []


var dice1Value = 2
var dice2Value = 3
# Called when the node enters the scene tree for the first time.
func _ready():
	##### Store Tile Locations ######
	for child in $Tiles.get_children():
		if(child.player1Sequence != 0):
			player1Tiles.append(child)
		if(child.player2Sequence != 0):
			player2Tiles.append(child)
	player1Tiles.sort_custom(self,"_sortP1Tiles")
	player2Tiles.sort_custom(self,"_sortP2Tiles")
	###### Create Player Tokens ######
	var playerScene = preload("res://Player/Player.tscn")
	for i in range(playerPieces):
		player1Pieces.append(playerScene.instance())
		player1Pieces[i].init(1, i, player1Tiles, $Player1Home, $Player1Goal, $Dice1)
		add_child(player1Pieces[i])
		player2Pieces.append(playerScene.instance())
		player2Pieces[i].init(2, i, player2Tiles, $Player2Home, $Player2Goal, $Dice2)
		add_child(player2Pieces[i])
	 

func playerSelected():
	print("selected")
	
func playerMoved():
	print("moved")

func _sortP1Tiles(a,b):
	return a.player1Sequence < b.player1Sequence
func _sortP2Tiles(a,b):
	return a.player2Sequence < b.player2Sequence

