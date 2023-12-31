extends Node

@export var monster_scene = preload("res://monster.tscn")
@export var shiba_scene = preload("res://blueshiba.tscn")
@export var bear_scene = preload("res://bear.tscn")

var shiba_jump_time = false

func _ready():
	randomize()

func _on_mob_timer_timeout():
	var monster = monster_scene.instantiate()
	var shiba = shiba_scene.instantiate()
	var bear = bear_scene.instantiate()
	
	var shiba_spawn = randi_range(0, 11)
	var bear_spawn = randi_range(0, 11)
	
	if (shiba_spawn == 10):
		_intialise_and_add(shiba)
	
	if (bear_spawn == 10):
		_intialise_and_add(bear)
	
	_intialise_and_add(monster)

func _on_frog_hit():
	$MobTimer.stop()
	$UserInterface/Retry.show()

func _unhandled_input(event):
	if event.is_action_pressed("ui_accept") and $UserInterface/Retry.visible:
		get_tree().reload_current_scene()
		

func _intialise_and_add(enemy):
	var enemy_spawn_location = $SpawnPath/SpawnLocation
	enemy_spawn_location.progress_ratio = randf()
	
	var player_position = Vector3 ($Frog.position.x, 0, $Frog.position.z)
	
	enemy.squashed.connect(Callable($UserInterface/ScoreLabel, "_on_enemy_squashed").bind(enemy))
	
	enemy.initialise(enemy_spawn_location.position, player_position)
	
	add_child(enemy)
