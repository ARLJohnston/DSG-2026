extends Node2D

class_name Card


var offset: Vector2
var initial_pos: Vector2
var reference_pos: StaticBody2D
var at_drop_area = false
var dragging = false


var click_area = 64 # this number is arbitrary, but it seems to work?


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
	pass

func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if (event.position - self.position).length() < click_area:
			if not dragging and event.pressed:
				dragging = true
		
		if dragging and not event.pressed:
			dragging = false
	
	if event is InputEventMouseMotion and dragging:
		# 0.1 is "delay", go lower if you want snappy, go higher if you want laggy
		var tween = get_tree().create_tween()
		tween.tween_property(self,"position",event.position,0.1).set_ease(Tween.EASE_OUT)
		
func _on_area_2d_body_entered(body:StaticBody2D) -> void:
	if body.is_in_group("droppable"):
		at_drop_area = true
		reference_pos = body
		print("in drop area")
		
func _on_area_2d_body_exited(body):
	if body.is_in_group("droppable"):
		at_drop_area = false
		print("out of drop area")
	

		
		
		
