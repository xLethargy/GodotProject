extends CanvasLayer

signal change_song(song)

var game = "res://GameScene.tscn"
var count : int = 0

var lofi_stream = preload("res://Napoleon's song (Amour Plastique- slowed version).mp3")
var french_stream = preload("res://France's Most Stereotypical Music.mp3")

func _ready():
	$"../AudioStreamPlayer".stream = Global.music_stream
	$"../AudioStreamPlayer".play(Global.music_progress)
	
	if Global.lofi_mode == true:
		$ColorRect.visible = true

func _on_play_pressed():
	
	get_tree().call_deferred("change_scene_to_file", game)
	Global.music_progress = $"../AudioStreamPlayer".get_playback_position()


func _on_exit_pressed():
	count = (count % 5) + 1
	
	if count == 1:
		$Exit.text = "no"
	elif count == 2:
		$Exit.text = "you can't leave"
	elif count == 3:
		$Exit.text = "keep trying noob..."
	elif count == 4:
		$Exit.text = "ok maybe you can"
	elif count == 5:
		get_tree().quit()

func _on_lofi_mode_pressed():
	$ColorRect.visible = !$ColorRect.visible
	Global.lofi_mode = !Global.lofi_mode
	Global.music_progress = 0
	
	if Global.lofi_mode == true:
		Global.music_stream = lofi_stream
	else:
		Global.music_stream = french_stream
	
	$"../AudioStreamPlayer".stream = Global.music_stream
	$"../AudioStreamPlayer".play(Global.music_progress)
