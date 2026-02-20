extends Node2D

class_name Card


var offset: Vector2
var initial_pos: Vector2
var at_drop_area = false


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

func _process(delta):
	if Input.is_action_just_pressed("ui_left"):
		initial_pos = global_position
		offset = get_global_mouse_position() - global_position
		World.set_dr
