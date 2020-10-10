extends Node

export var piecesPerPlayer := 5

const STATES = ["P1ROLE, P1PLAY, P1ANIMATE, P2ROLE, P2PLAY, P2ANIMATE"]

var playerTiles : = [null,[],[]]
var playerPieces : =  [null,[],[]]

var playerPoints := [null,0,0]
onready var dice := [null,$Dice1, $Dice2]

# Called when the node enters the scene tree for the first time.
func _ready():
	dice[1].playerId = 1
	dice[2].playerId = 2
	##### Store Tile Locations ######
	for child in $Tiles.get_children():
		if(child.player1Sequence != 0):
			playerTiles[1].append(child)
		if(child.player2Sequence != 0):
			playerTiles[2].append(child)
	playerTiles[1].sort_custom(self,"_sortP1Tiles")
	playerTiles[2].sort_custom(self,"_sortP2Tiles")
	
	
	###### Create Player Tokens ######
	var playerScene = preload("res://Player/Player.tscn")
	for i in range(piecesPerPlayer):
		playerPieces[1].append(playerScene.instance())
		playerPieces[1][i].init(1, i, playerTiles[1], $Player1Home, $Player1Goal, $Dice1)
		_addPlayerPiece(playerPieces[1][i])
		playerPieces[2].append(playerScene.instance())
		playerPieces[2][i].init(2, i, playerTiles[2], $Player2Home, $Player2Goal, $Dice2)
		_addPlayerPiece(playerPieces[2][i])
	 
	####### Start Game Cycle #######
		dice[2].hide()
		

func _on_pieceSelected(playerId):
	for piece in playerPieces[playerId]:
		piece.playerTurn = false
	dice[playerId].hide()
	
func _on_pieceMoved(playerId):
	if (playerId == 1):
		dice[2].reset()	
	if(playerId == 2):
		dice[1].reset()

func _on_diceRolled(playerId):
	if(hasPossibleMoves(playerPieces[playerId])):
		for piece in playerPieces[playerId]:
				piece.playerTurn = true
	else:
		dice[playerId].noMoves()
		_on_pieceMoved(playerId)


func _on_pieceGoal(playerId):
	playerPoints[playerId] += 1
	if(playerPoints[playerId] == piecesPerPlayer):
		print("Player "+ String(playerId) +" Wins")

func _addPlayerPiece(piece : Object):
		add_child(piece)
		piece.connect("pieceSelected",self,"_on_pieceSelected")
		piece.connect("pieceMoved",self,"_on_pieceMoved")
		piece.connect("pieceGoal", self,"_on_pieceGoal")

func _sortP1Tiles(a,b):
	return a.player1Sequence < b.player1Sequence
func _sortP2Tiles(a,b):
	return a.player2Sequence < b.player2Sequence

func hasPossibleMoves(pieces):
	for piece in pieces:
		if(piece.canMove()):
			return true
	return false


