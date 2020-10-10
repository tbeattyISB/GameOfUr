extends Node2D

class_name Player

signal pieceSelected
signal pieceMoved
signal pieceGoal
signal extraRole

export var playerId : int
var stackSpace : = Vector2(0,-5)
var progress : = 0
var selectable : = true
var playerTurn : = false

var tiles : Array
var homeStack : Node2D
var goalStack : Node2D
var dice : Node2D

func init(playerId : int, stackOffset : int, tiles: Array, homeStack : Node2D, goalStack : Node2D, dice : Node2D):
	self.tiles = tiles
	self.playerId = playerId
	if(playerId == 1):
		$PlayerSprite.modulate = Color(1.5,1.5,1.5)
	else:
		$PlayerSprite.modulate = Color(0.5,0.5,0.5)
	self.homeStack = homeStack
	self.goalStack = goalStack
	self.dice = dice
	home()
	

func home():
	progress = 0
	raise()
	self.set_position(homeStack.get_position() + stackSpace * homeStack.add(self))

func goal():
	unselectable()
	raise()
	self.set_position(goalStack.get_position() + stackSpace * goalStack.add(self))

func selectable():
	selectable = true
	pass
	
func unselectable():
	selectable = false
	pass

func canMove():
	var possibleProgress = progress + dice.diceVal
	if(selectable == false or dice.diceVal == 0):
		return false
	if(possibleProgress > tiles.size()+1):
		return false
	if(possibleProgress == tiles.size()+1):
		return true
	print(self)
	if(tiles[possibleProgress-1].canOccupy(self)):
		return true
	return false
		
func _input_event(viewport, event, shape_idx):
	# Selectability (in stack) and player turn need to be true
	# Roll needs to be higher than 0.. game logi
	if(event.is_action_pressed('click') and selectable and playerTurn and canMove()): 

		#Check where the piece would move
		var possibleProgress = progress + dice.diceVal
		#is the piece movign off the board? (0 for home, size+1for goal)
		if(possibleProgress > tiles.size()):
			tiles[progress-1].leaveTile()
			progress = possibleProgress
			emit_signal("pieceSelected", playerId)
			goal()
			emit_signal("pieceMoved", playerId)
			emit_signal("pieceGoal", playerId)
		#the piece can move to an open space			
		else:
			emit_signal("pieceSelected", playerId)
			self.set_position(tiles[possibleProgress-1].get_position())
			if(progress == 0):
				homeStack.removeTop()
			else:
				tiles[progress-1].leaveTile()
			tiles[possibleProgress-1].occupy(self)
			progress = possibleProgress
			if(tiles[progress-1].extraRole == true):
				emit_signal("extraRole",playerId)
			else:
				emit_signal("pieceMoved", playerId)
			#animate?


