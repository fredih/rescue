extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var move 

# Called when the node enters the scene tree for the first time.
func _ready():
	move = false
	$Timer.connect("timeout",self,"timeout")
	$Timer.start()

func timeout():
	move = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$RichTextLabel.percent_visible += 0.01
	if move :
		$RichTextLabel.percent_visible = 0
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
				
	
