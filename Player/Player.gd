extends Node2D

class_name Player

signal pieceSelected
signal pieceMoved
export var playerId : int
var stackSpace : = Vector2(0,-5)
var progress : = 0
var selectable : = true
var done : = false

var tiles : Array
var home : Node2D
var goal : Node2D


func init(playerId : int, stackOffset : int, tiles: Array, homePos : Node2D, goalPos : Node2D, dice : Node2D):
	#connect("pieceSelected",get_parent(),"playerSelected",)
	#connect("pieceMoved",get_parent(),"playerMoved")
	self.tiles = tiles
	self.playerId = playerId
	self.home = homePos
	self.goal = goalPos
	home()
	

func home():
	progress = 0
	raise()
	self.set_position(home.get_position() + stackSpace * home.add(self))

func goal():
	unselectable()
	done = true
	raise()
	self.set_position(goal.get_position() + stackSpace * goal.add(self))

func selectable():
	selectable = true
	pass
	
func unselectable():
	selectable = false
	pass
#
func _input_event(viewport, event, shape_idx):
	# Selectability (in stack) and player turn need to be true
	# Roll needs to be higher than 0.. game logic
	
	if(event.is_action_pressed('click') and selectable): 
		#Check where the piece would move
		var possibleProgress = progress + 2 #dicevalue
		#is the piece movign off the board? (0 for home, size+1for goal)
		print(progress)
		if(possibleProgress > tiles.size()):
			if(possibleProgress > tiles.size()+1):
				print("No Move")
				pass #Roll was too big animate shake
			else:
				tiles[progress-1].leaveTile()
				progress = possibleProgress
				emit_signal("pieceSelected")
				goal()
				emit_signal("pieceMoved")
				
				
		else:
			if(tiles[possibleProgress-1].occupy(self)):
				emit_signal("pieceSelected")
				self.set_position(tiles[possibleProgress-1].get_position())
				if(progress == 0):
					home.removeTop()
				else:
					tiles[progress-1].leaveTile()
				progress = possibleProgress
				emit_signal("pieceMoved")
				#animate?
			else:
				print("No Move")
				#animate negate
				pass
