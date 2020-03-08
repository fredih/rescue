extends Actor

var target
var isLit = false
var playerPointer
var result
var state = "scared"
var throwForce = Vector2(-200,-300)
var frictionWhenDead = 10
export var maxDistance = 10
func _ready():
	speed.x = 2.5
	gravity = 800

func _process(delta):
	pass
	
		
func _physics_process(delta: float) -> void:
	if target.get_node("AnimatedSprite").flip_h:
		throwForce.x = abs(throwForce.x)
	else:
		throwForce.x = -abs(throwForce.x)
		
	match state:
		"happy":
			isLit = false
			$lobinSprite.animation = "Idle"
			if abs(target.position.x - position.x) > maxDistance or !target.isLit:
				state = "scared"
			if Input.is_action_just_pressed("ui_throw"):
				isLit = true
				_velocity = throwForce
				state = "throwed"
			
		"scared":
			isLit = false
			raycastPlayer()
			$lobinSprite.animation = "Scared"
			if result and target.isLit and result.collider == target:
				state = "reachingPlayer"
			elif abs(target.position.x - position.x) < maxDistance and Input.is_action_just_pressed("ui_throw"):
				state = "throwed"
				_velocity = throwForce
				
		"reachingPlayer":
			isLit = false
			raycastPlayer()
			_velocity.x = speed.x * (target.position.x - position.x)
			if abs(_velocity.x) > 150:
				$lobinSprite.animation = "Run"
			else:
				$lobinSprite.animation = "Walk"
				
			if !target.isLit  or !(result.collider == target):
					_velocity.x = 0
					state = "scared"
			elif abs(target.position.x - position.x) < maxDistance:
					_velocity.x = 0
					state = "happy"
		"throwed":
			$lobinSprite.animation = "Scared"
			if is_on_floor():
				_velocity.x = 0
				state = "scared"
		"Got_Hit":
			$lobinSprite.animation = "Hit"
			if is_on_floor():
				_velocity.x -=  frictionWhenDead * sign(_velocity.x)
		"Got_Death_Damage":
			$lobinSprite.animation = "Hit"
			yield(get_tree().create_timer(0.4), "timeout")
			.queue_free()
			
	_velocity = move_and_slide(_velocity, FLOOR_NORMAL, false)
	$Light.enabled = isLit
	if state != "Got_Hit":
		if _velocity.x < 0:
			$lobinSprite.flip_h = true
		elif _velocity.x > 0:
			$lobinSprite.flip_h = false
			

func raycastPlayer():
	#raycasting player
	var space_state = get_world_2d().direct_space_state
	result = space_state.intersect_ray(position, target.position, [self])


func _on_lobinSprite_animation_finished():
	if $lobinSprite.animation == "Hit":
		queue_free()


func playPop():
	$pop.play()
