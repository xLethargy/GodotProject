extends CharacterBody3D

signal hit

@export var speed = 13.0
@export var jump_impulse = 25.0
@export var fall_accelaration = 75.0
@export var bounce_impulse = 20.0

var rotation_speed = 15.0

func _physics_process(delta):
	var direction = Vector3.ZERO
	
	if Input.is_action_pressed("sprint") and !Input.is_action_pressed("jump") and is_on_floor():
		speed = 25.0
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
		
		# smooth rotation
		self.rotation.y = lerp_angle(self.rotation.y, atan2( -direction.x , -direction.z), delta * rotation_speed)
	
	velocity.x = direction.x * speed
	velocity.z = direction.z * speed
	
	if is_on_floor() and Input.is_action_pressed("jump"):
		velocity.y = jump_impulse
	
	velocity.y -= fall_accelaration * delta
	
	move_and_slide()



func die():
	emit_signal("hit")
	queue_free()

func _on_squash_detection_body_entered(body):
	if body != null and body.is_in_group("monster"):
		velocity.y = bounce_impulse

func change_material():
	var gold = preload("res://gold.tres")
	%Body.set_surface_override_material(0, gold)


func _on_hitbox_detection_body_entered(_body):
	die()
