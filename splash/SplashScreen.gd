extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $Camera2D.position.y < 330:
		$Camera2D.position.y += 1.6
	
	else:
		if $RescueTitleText.position.y < 385:
			if $RescueTitleText.position.y < 90:
				print($RescueTitleText.position.y)
				$RescueTitleText.position.y += 30
			else:
				$RescueTitleText.position.y += 2.8
		else:
			if $pressStart.position.y > 450:
				$pressStart.position.y -= 1.2
			
	
