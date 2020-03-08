extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_start"):
		get_tree().change_scene("res://levels/NoEnemies.tscn")
	if $Camera2D.position.y < 330:
		$Camera2D.position.y += 1.6
	
	else:
		if $RescueTitleText.position.y < 385:
			if $RescueTitleText.position.y < 100:
				$RescueTitleText.position.y += 30
			else:
				$RescueTitleText.position.y += 3.2
		else:
			if $pressStart.position.y > 450:
				$pressStart.position.y -= 1.2
			
	
