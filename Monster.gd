extends CharacterBody3D

signal squashed

@export var min_speed = 7
@export var max_speed = 10


var is_squashed = false
var is_spinning = false
var fall_accelaration = 75

func _physics_process(delta):
	if is_spinning:
		rotate_y(0.1)
		velocity.y -= fall_accelaration * delta

	move_and_slide()
	
func initialise(start_position, player_position):
	look_at_from_position(start_position, player_position, Vector3.UP)
	rotate_y(randf_range(-PI / 4.0, PI / 4.0))
	
	if self.is_in_group("shiba"):
		is_spinning = true
		
	
	var random_speed = randf_range(min_speed, max_speed)
	velocity = Vector3.FORWARD * random_speed
	velocity = velocity.rotated(Vector3.UP, rotation.y)
	
func squash():
	if is_squashed == false:
		is_squashed = true
		emit_signal("squashed")
		queue_free()

func _on_visible_on_screen_notifier_3d_screen_exited():
	queue_free()
	

func _on_shiba_jumper_timer_timeout():
	var shiba_jump = randi_range(0, 1)
	
	if is_on_floor() and shiba_jump == 1:
		self.velocity.y = 20
