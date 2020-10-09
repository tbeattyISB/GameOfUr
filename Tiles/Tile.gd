extends Node2D

class_name Tile

export var player1Sequence : int = 0
export var player2Sequence : int = 0	
export var extraRole : bool = false
export var safeArea : bool = false	
var occupant : Object = null

func occupy(player):
	if(occupant != null):
		#Players cannot bump their own pieces
		if(occupant.playerId == player.playerId):
			return false
		elif(safeArea):
			return false
		else:
			occupant.home()
			occupant = player
			return true
	else:
		occupant = player
		return true

func leaveTile():
	occupant = null
