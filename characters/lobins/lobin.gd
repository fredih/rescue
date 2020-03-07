extends KinematicBody2D

var isLit
var target
var playerPos = Vector2()
var playerPointer
var velocity = Vector2()

func _ready():
	pass # Replace with function body.


func _process(delta):
	if isLit:
		playerPointer = playerPos - position
		velocity = playerPointer.normalized()
		
func _physics_process(delta):
	var space_state = get_world_2d().direct_space_state
	var result = space_state.intersect_ray(global_position, enemy_position, [self])
