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
	body._velocity = -body._velocity
	if body.get_name() == "Lobin":
		if body.isLit:
			$AnimatedSprite.animation = "Dead"
			print("dead")
		elif body.state != "Got_Hit":
			$AnimatedSprite.animation = "Scream"
			body.state = "Got_Hit"


func _on_ScreamArea_body_entered(body):
	if body.get_name() == "Lobin" and body.state != "Got_Hit" and !body.isLit:
			$AnimatedSprite.animation = "Scream"
			body.state = "Got_Hit"
