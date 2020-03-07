extends Actor

var target
var playerPointer
var result
var state = "scared"
export var maxDistance = 10
func _ready():
	speed.x = 1.5
	gravity = 800

func _process(delta):
	pass
	#_velocity = _velocity.normalized()
	
		
func _physics_process(delta: float) -> void:
	match state:
		"happy":
			$lobinSprite.animation = "Idle"
			if abs(target.position.x - position.x) > maxDistance:
				state = "scared"
				$lobinSprite.animation = "Walk"
			move_and_slide(_velocity, FLOOR_NORMAL, false)
			
		"scared":
			#raycasting player
			var space_state = get_world_2d().direct_space_state
			result = space_state.intersect_ray(position, target.position, [self])
			#if ray hits player, move. If not, don't
			if result and target.isLit and result.collider == target:
				_velocity.x = speed.x * (target.position.x - position.x)
			else:
				_velocity.x = 0
			move_and_slide(_velocity, FLOOR_NORMAL, false)
			if abs(target.position.x - position.x) < maxDistance:
				_velocity.x = 0
				state = "happy"
		
		
