extends Label

signal gold_score

var is_gold : bool = false
var score = 0

func _ready():
	pass

func _on_enemy_squashed(enemy):
	if enemy.is_in_group("crocodile"):
		score += 1
	elif enemy.is_in_group("shiba"):
		score += 5
	elif enemy.is_in_group("bear"):
		score += 10
	
	text = "Score: %s" % score
	
	if score >= 50 and !is_gold:
		emit_signal("gold_score")
		is_gold = true

func get_score():
	return score
