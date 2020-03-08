extends Actor

var screen_size
export var isLit = false
var isThrowing = false
var direction
var hasLobin = false

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	$AnimatedSprite.flip_h = true
	$AnimatedSprite.animation = "idle"
	$AnimatedSprite.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_lit"):
		isLit = !isLit
		$Light.energy = 5.0 if (isLit) else 0


func _physics_process(delta: float) -> void:
	var is_jump_interrupted: = Input.is_action_just_released("ui_up") and _velocity.y < 0.0
	direction = get_direction()
	_velocity = calculate_move_velocity(direction, is_jump_interrupted)
	var snap: Vector2 = Vector2.DOWN * 10.0 if direction.y == 0.0 else Vector2.ZERO
	_velocity = move_and_slide_with_snap(
		_velocity, snap, FLOOR_NORMAL, true
	)
	if Input.is_action_just_pressed("ui_throw"):
		isThrowing = true
	animate(direction)

func get_direction() -> Vector2:
	return Vector2(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		-Input.get_action_strength("ui_up") if is_on_floor() and Input.is_action_just_pressed("ui_up") else 0.0
	)
	
func calculate_move_velocity(
		direction: Vector2,
		is_jump_interrupted: bool
	) -> Vector2:
	var velocity: = _velocity
	velocity.x = speed.x * direction.x
	if direction.y != 0.0:
		velocity.y = speed.y * direction.y
	if is_jump_interrupted:
		velocity.y = 0.0
	return velocity
	
func animate(direction):
	
	if isThrowing:
		$AnimatedSprite.animation = "attack"
		$AnimatedSprite.speed_scale = 6
		return
	elif _velocity.y > 0:
		$AnimatedSprite.animation = "jump"
	elif _velocity.x != 0:
		$AnimatedSprite.animation = "run"
	else:
		$AnimatedSprite.animation = "idle"
	
	if direction.x > 0:
		$AnimatedSprite.flip_h = true
	elif direction.x < 0:
		$AnimatedSprite.flip_h = false
		
	


func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite.animation == "attack":
		$AnimatedSprite.speed_scale = 1
		isThrowing = false
		animate(direction)
