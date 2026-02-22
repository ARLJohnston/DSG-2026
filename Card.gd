extends Node2D

class_name Card


var offset: Vector2
var initial_pos: Vector2
var reference_pos: Area2D
var at_drop_area = false
var dragging = false
var outcome: String


var card_values: Dictionary[Values.Maat, int] = {
	Values.Maat.balance: 0,
 	Values.Maat.harmony: 0,
 	Values.Maat.justice: 0,
 	Values.Maat.law: 0,
 	Values.Maat.morality:0,
 	Values.Maat.order:0,
 	Values.Maat.truth: 0  
}

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_released() and at_drop_area:
		onChoose()

func onChoose() -> void:
	print(self.outcome)
	for k in card_values:
		if card_values[k] != 0:
			global_score.game_score[k] = card_values[k]
	message_bus.FADE_OUT.emit(self.outcome)
	message_bus.ROUND_END.emit()

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("dropzone"):
		var fade_in_background_music = create_tween()
		fade_in_background_music.tween_property($Area2D/Pickup, "volume_db", +20.0, 1)
		$Area2D/Pickup.play()
		at_drop_area = true
		reference_pos = area
		print("in drop area")


func _on_area_2d_area_exited(area: Area2D) -> void:
	if area.is_in_group("dropzone"):
		var fade_out_background_music = create_tween()
		fade_out_background_music.tween_property($Area2D/Pickup, "volume_db", -20.0, 1)
		at_drop_area = false
		print("out of drop area")
