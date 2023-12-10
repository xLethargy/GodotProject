extends Label

var score = 0

func _on_enemy_squashed(enemy):
	if enemy.is_in_group("crocodile"):
		score += 1
	elif enemy.is_in_group("shiba"):
		score += 5
	elif enemy.is_in_group("bear"):
		score += 10
	
	text = "Score: %s" % score
