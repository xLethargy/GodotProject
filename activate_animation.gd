extends Node3D

@export var animation_player_path : NodePath
@onready var animation_player : AnimationPlayer = get_node(animation_player_path)

# Called when the node enters the scene tree for the first time.
func _ready():
	GameManager.greeting()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("activate"):
		animation_player.play("cube_loop")
		pass

