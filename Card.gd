extends Node

class_name Card

var card_values: Dictionary[Values.Maat, int] = {
	Values.Maat.balance: 0,
 	Values.Maat.harmony: 0,
 	Values.Maat.justice: 0,
 	Values.Maat.law: 0,
 	Values.Maat.morality:0,
 	Values.Maat.order:0,
 	Values.Maat.truth: 0  
}

func onChoose() -> void:
	var m = Values.new()
	for k in card_values:
		if card_values[k] != 0:
			global_score.game_score[k] = card_values[k]
	pass
