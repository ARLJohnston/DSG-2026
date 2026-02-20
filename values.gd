extends Node

class_name Values

enum Maat {truth, balance, order, harmony, law, morality, justice}



func score(foo,bar) -> void:
	
	# inits
	if foo not in global_score.game_score.keys():
		global_score.game_score[foo] = 0
		
	global_score.game_score[foo] += bar
