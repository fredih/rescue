extends Actor

var target
var playerPointer
var result

func _ready():
	pass # Replace with function body.


func _process(delta):
	_velocity.x = target.position.x - position.x
	_velocity = _velocity.normalized()
	
	if target.isLit and result.collider == target:
		position.x += _velocity.x * delta * speed.x
		
func _physics_process(delta):
	var space_state = get_world_2d().direct_space_state
	result = space_state.intersect_ray(position, target.position, [self])
	._physics_process(delta)
