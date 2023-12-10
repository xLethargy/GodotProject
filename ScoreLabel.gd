extends Label

var score = 0

func _on_enemy_squashed(enemy):
	print (enemy.name)
	if enemy.is_in_group("crocodile"):
		score += 1
	else:
		score += 3
	
	text = "Score: %s" % score
