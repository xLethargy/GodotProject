extends Node

@export var monster_scene = preload("res://monster.tscn")

func _ready():
	
	randomize()

func _on_mob_timer_timeout():
	var monster = monster_scene.instantiate()
	
	var player_position = Vector3 ($Frog.position.x, 0, $Frog.position.z)
	var monster_spawn_location = $SpawnPath/SpawnLocation
	monster_spawn_location.progress_ratio = randf()
	
	monster.initialise(monster_spawn_location.position, player_position)
	
	add_child(monster)


func _on_frog_hit():
	$MobTimer.stop()
