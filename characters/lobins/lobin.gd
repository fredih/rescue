extends Actor

var target
var playerPointer
var velocity = Vector2()

func _ready():
	pass # Replace with function body.


func _process(delta):
	if target.isLit:
		
		
func _physics_process(delta):
	var space_state = get_world_2d().direct_space_state
	var result = space_state.intersect_ray(global_position, enemy_position, [self])
