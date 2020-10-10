extends Area2D

signal diceRolled

var diceVal = null
var rollable = false
var playerId = null
var gameOver = false

var probabilities = [ [0, 6.25],
					[1, 25],
					[2, 37.5],
					[3, 25],
					[4, 6.25]]

var totalProb = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	for prob in probabilities:
		totalProb = totalProb + prob[1]

func reset():
	diceVal = null
	$Label.text = "Roll Dice"
	show()
	
func noMoves():
	$Label.text = "No Moves: "+$Label.text
	
func win(text):
	show()
	$Label.text = text
	
func gameOver():
	hide()
	gameOver = true;

func _input_event(viewport, event, shape_idx):
	if(event.is_action_pressed('click') and !gameOver):
		randomize()
		var tempRand = randf()*totalProb
		print(tempRand)
		var rampProb = 0
		var i = 0
		while(diceVal == null):
			rampProb = rampProb + probabilities[i][1]
			if(rampProb > tempRand):
				diceVal = probabilities[i][0]
			i= i+1
		$Label.text = String(diceVal)
		emit_signal("diceRolled", playerId)
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
