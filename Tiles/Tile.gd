extends Node2D

class_name Tile

export var player1Sequence : int = 0
export var player2Sequence : int = 0	
export var extraRole : bool = false
export var safeArea : bool = false	
var occupant : Object = null

func canOccupy(player):
	if(occupant != null):
		if(occupant.playerId == player.playerId):
			return false
		elif(safeArea):
			return false
	return true	
		
func occupy(player):
	if(occupant != null):
		occupant.home()
		occupant = player
	else:
		occupant = player

func leaveTile():
	occupant = null
