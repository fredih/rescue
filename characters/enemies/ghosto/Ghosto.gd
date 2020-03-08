extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite.animation == "Dead":
		queue_free()
	if $AnimatedSprite.animation == "Scream":
		$AnimatedSprite.animation = "Idle"


func _on_Ghosto_body_entered(body):
	if body.get_name() == "Lobin":
		body._velocity = -body._velocity
		if body.isLit:
			$deadSound.play()
			$AnimatedSprite.animation = "Dead"
			$ScreamArea.queue_free()
			$CollisionShape2D.queue_free()
			$AnimatedSprite.speed_scale = 1.5
			print("dead")
		elif body.state != "Got_Hit":
			$laugh.play()
			$AnimatedSprite.animation = "Scream"
			body.state = "Got_Hit"
	if body.get_name() == "Player" and $AnimatedSprite.animation == "Idle":
		$laugh.play()
		$AnimatedSprite.animation = "Scream"


func _on_ScreamArea_body_entered(body):
	if body.get_name() == "Lobin" and body.state != "Got_Hit" and !body.isLit:
		body.playPop()
		$laugh.play()
		$AnimatedSprite.animation = "Scream"
		body.state = "Got_Hit"


func _on_laugh_finished():
	$laugh.stop()


#func _on_hauntedArea_body_entered(body):
#	if body.get_name() == "Player":
#		$hauntedSound.play()
