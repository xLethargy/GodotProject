extends Node

@export var monster_scene = preload("res://monster.tscn")
@export var shiba_scene = preload("res://blueshiba.tscn")

func _ready():
	randomize()

func _on_mob_timer_timeout():
	var monster = monster_scene.instantiate()
	var shiba = shiba_scene.instantiate()
	
	var shiba_spawn = randi_range(0, 11)
	
	if (shiba_spawn == 10):
		_intialise_and_add(shiba)
	
	_intialise_and_add(monster)
	

func _on_frog_hit():
	$MobTimer.stop()

func _intialise_and_add(enemy):
	var enemy_spawn_location = $SpawnPath/SpawnLocation
	enemy_spawn_location.progress_ratio = randf()
	
	var player_position = Vector3 ($Frog.position.x, 0, $Frog.position.z)
	
	enemy.squashed.connect(Callable($UserInterface/ScoreLabel, "_on_enemy_squashed"))
	
	enemy.initialise(enemy_spawn_location.position, player_position)
	
	add_child(enemy)
