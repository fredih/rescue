extends Actor

var target
var isLit = false
var playerPointer
var result
var state = "scared"
var throwForce = Vector2(0,-450)
export var maxDistance = 10
func _ready():
	speed.x = 2.5
	gravity = 800

func _process(delta):
	pass
	#_velocity = _velocity.normalized()
	
		
func _physics_process(delta: float) -> void:
	
	match state:
		"happy":
			$lobinSprite.animation = "Idle"
			if abs(target.position.x - position.x) > maxDistance or !target.isLit:
				state = "scared"
			if Input.is_action_just_pressed("ui_throw"):
				isLit = true
				_velocity = throwForce
				state = "throwed"
			
		"scared":
			raycastPlayer()
			$lobinSprite.animation = "Scared"
			if result and target.isLit and result.collider == target:
				state = "reachingPlayer"
			elif abs(target.position.x - position.x) < maxDistance and Input.is_action_just_pressed("ui_throw"):
				state = "throwed"
				isLit = false
				_velocity = throwForce
				
		"reachingPlayer":
			raycastPlayer()
			$lobinSprite.animation = "Walk"
			_velocity.x = speed.x * (target.position.x - position.x)
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
			
			
	_velocity = move_and_slide(_velocity, FLOOR_NORMAL, false)
	$Light.enabled = isLit
			
		
		
func raycastPlayer():
	#raycasting player
	var space_state = get_world_2d().direct_space_state
	result = space_state.intersect_ray(position, target.position, [self])
