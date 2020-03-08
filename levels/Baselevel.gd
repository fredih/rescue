extends Node2D
class_name Baselevel

func _ready():
	$Lobin.target = $Player
	
	
func _process(delta):
	if Input.is_action_just_pressed("ui_restart"):
		get_tree().reload_current_scene()
