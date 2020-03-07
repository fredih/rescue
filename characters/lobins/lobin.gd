extends Actor

var target
var playerPointer
var velocity = Vector2()
var result

func _ready():
	pass # Replace with function body.


func _process(delta):
	velocity = target.position - position
	velocity.y = 0
	velocity = velocity.normalized()
	
	if target.isLit and result.collider == target:
		position += velocity * delta * speed.x
		
		
func _physics_process(delta):
	var space_state = get_world_2d().direct_space_state
	result = space_state.intersect_ray(position, target.position, [self])
