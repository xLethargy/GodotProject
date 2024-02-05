extends Node

var music_progress = 0.0

var french_stream = preload("res://France's Most Stereotypical Music.mp3")

var lofi_mode = false:
	set(value):
		lofi_mode = value

var music_stream = french_stream:
	set(value):
		music_stream = value
