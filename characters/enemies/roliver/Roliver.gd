extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var limitAttackRange 
var returnToOriginalPosition
var originalPosition

var attack = false
# Called when the node enters the scene tree for the first time.
func _ready():
	originalPosition = position.y
	limitAttackRange = originalPosition - 30
	returnToOriginalPosition = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if returnToOriginalPosition:
		position.y += 1;	
		if(position.y >= originalPosition):
			$AnimatedSprite.animation = "Idle"
			position.y = originalPosition
			returnToOriginalPosition = false	
	elif attack:
		position.y -= 5;
		if(position.y <= limitAttackRange):
			returnToOriginalPosition = true
			attack = false


func _on_Area2D_body_entered(body):
	if body.name == "Lobin" and body.isLit:
		attack = true
		$AnimatedSprite.animation = "Attack"
		
		


func _on_Area2D2_body_entered(body):
	pass
	if body.name == "Lobin":
		body.state = "Got_Death_Damage"
