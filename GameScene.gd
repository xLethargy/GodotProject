extends Node

var monster_scene = preload("res://monster.tscn")
var shiba_scene = preload("res://blueshiba.tscn")
var bear_scene = preload("res://bear.tscn")

var shiba_jump_time = false

var menu = "res://main_menu.tscn"

func _ready():
	randomize()
	
	$AudioStreamPlayer.stream = Global.music_stream
	$AudioStreamPlayer.play(Global.music_progress)
	
	if Global.lofi_mode == true:
		$UserInterface/ColorRect.visible = true
	
	

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
		Global.music_progress = $AudioStreamPlayer.get_playback_position()
	if event.is_action_pressed("ui_cancel"):
		get_tree().call_deferred("change_scene_to_file", menu)
		Global.music_progress = $AudioStreamPlayer.get_playback_position()
		

func _intialise_and_add(enemy):
	var enemy_spawn_location = $SpawnPath/SpawnLocation
	enemy_spawn_location.progress_ratio = randf()
	
	var player_position = Vector3 ($Frog.position.x, 0, $Frog.position.z)
	
	enemy.squashed.connect(Callable($UserInterface/ScoreLabel, "_on_enemy_squashed").bind(enemy))
	
	enemy.initialise(enemy_spawn_location.position, player_position)
	
	add_child(enemy)


func _on_score_label_gold_score():
	$Frog.change_material()
	
