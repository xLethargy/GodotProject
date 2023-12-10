extends CharacterBody3D

signal squashed

@export var min_speed = 7
@export var max_speed = 10

var is_spinning = false
var fall_accelaration = 75
var bear_health = 5

func _physics_process(delta):
	_shiba_spinner(delta)
	move_and_slide()

func initialise(start_position, player_position):
	look_at_from_position(start_position, player_position, Vector3.UP)
	rotate_y(randf_range(-PI / 4.0, PI / 4.0))
	var speed = randf_range(min_speed, max_speed)
	
	if self.is_in_group("shiba"):
		is_spinning = true
	
	if self.is_in_group("bear"):
		speed = 5
	
	velocity = Vector3.FORWARD * speed
	velocity = velocity.rotated(Vector3.UP, rotation.y)

func _on_shiba_jumper_timer_timeout():
	if is_on_floor():
		self.velocity.y = 20

func _shiba_spinner(delta):
	if is_spinning:
		rotate_y(0.1)
		velocity.y -= fall_accelaration * delta

func _on_squash_zone_body_entered(body):
	bear_health -= 1
	
	if !self.is_in_group("bear"):
		squash()
	elif bear_health == 0:
		squash()

func squash():
	emit_signal("squashed")
	queue_free()

func _on_visible_on_screen_notifier_3d_screen_exited():
	queue_free()
