extends Area2D

export var next_scene: PackedScene

var lobin
var checkWin : bool

func _ready():
	$Timer.connect("timeout",self,"waitForToChangeScene")
	

func waitForToChangeScene():
	win()

func _process(delta):
	if checkWin and lobin != null and lobin.state == "happy":
		checkWin = false
		$LevelCompletedSound.play()
		$Timer.start()
		

func win():
	get_tree().change_scene_to(next_scene)

func _on_Goal_body_entered(body):
	if body.name == "Lobin":
		lobin = body
		checkWin = true
		

func _on_Goal_body_exited(body):
	if body.name == "Lobin":
		checkWin = false
