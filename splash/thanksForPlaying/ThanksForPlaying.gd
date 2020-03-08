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
	get_tree().change_scene("res://splash/SplashScreen.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$RichTextLabel.percent_visible += 0.01
	
