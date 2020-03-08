extends Area2D

func _ready():
	$fire.stop()
	$fire2.stop()

func _on_fire2_animation_finished():
	$AnimatedSprite.animation = "Dead"
	$fireSound.stop()
	$fire.hide()
	$fire2.hide()
	$CollisionShape2D.queue_free()
	$ScreamArea.queue_free()
	print("finished_fire2_animation")

func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite.animation == "Dead":
		queue_free()
		
	

func _on_Zardo_body_entered(body):
	if body.get_name() == "Player" and body.isLit:
		$fireSound.play()
		$fire.show()
		$fire.play()
		$fire.animation = "first"
		$fire2.show()
		$fire2.play()
		$fire2.animation = "second"
	if body.get_name() == "Lobin":
		body.playPop()
		body._velocity = -body._velocity


func _on_fire_animation_finished():
	if $fire.animation == "first":
		$fire.animation = "continous"


func _on_ScreamArea_body_entered(body):
	if body.get_name() == "Lobin":
		$laugh.play()
		body.state = "Got_Hit"
