extends Area2D

export var next_scene: PackedScene

var lobin
var checkWin : bool

func _ready():
	pass # Replace with function body.

func _process(delta):
	if checkWin and lobin != null and lobin.state == "happy":
		win()

func win():
	get_tree().change_scene_to(next_scene)

func _on_Goal_body_entered(body):
	if body.name == "Lobin":
		lobin = body
		checkWin = true
		

func _on_Goal_body_exited(body):
	if body.name == "Lobin":
		checkWin = false
