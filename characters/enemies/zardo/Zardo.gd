extends Area2D



func _on_fire2_animation_finished():
	$AnimatedSprite.animation = "Dead"


func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite.animation == "Dead":
		queue_free()	
		
	

func _on_Zardo_body_entered(body):
	if body.get_name() == "Player" and body.isLit:
		$fire.show()
		$fire.animation = "first"
		$fire2.show()
		$fire2.animation = "second"


func _on_fire_animation_finished():
	if $fire.animation == "first":
		$fire.animation = "continous"
