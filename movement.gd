extends CharacterBody3D


@export var speed = 13.0
@export var jump_impulse = 20.0
@export var fall_accelaration = 75.0

var velocity_in = Vector3.ZERO
var rotation_speed = 15.0

func _physics_process(delta):
	var direction = Vector3.ZERO
	
	if Input.is_action_pressed("sprint") and !Input.is_action_pressed("jump"):
		speed = 20.0
	else:
		speed = 13.0
	
	if Input.is_action_pressed("move_right"):
		direction.x += 1
	if Input.is_action_pressed("move_left"):
		direction.x -= 1
		
	if Input.is_action_pressed("move_forward"):
		direction.z -= 1
	if Input.is_action_pressed("move_back"):
		direction.z += 1
		
	if direction != Vector3.ZERO:
		direction = direction.normalized()
		
		# snapping rotation
		#$Pivot.look_at(position + direction, Vector3.UP)
		
		# smooth rotation
		$Pivot.rotation.y = lerp_angle($Pivot.rotation.y, atan2( -direction.x , -direction.z), delta * rotation_speed)
	
	velocity.x = direction.x * speed
	velocity.z = direction.z * speed
	
	if is_on_floor() and Input.is_action_pressed("jump"):
		velocity.y += jump_impulse
	
	velocity.y -= fall_accelaration * delta
	
	velocity_in = move_and_slide()