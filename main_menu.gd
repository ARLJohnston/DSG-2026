extends Node


func _on_button_pressed() -> void:
	var fade_out_background_music = create_tween()
	fade_out_background_music.tween_property($BackgroundMusic, "volume_db", -20.0, 1)
	var fade_out_box = create_tween()
	$FadeOut.visible = true
	fade_out_box.tween_property($FadeOut, "color", Color(0,0,0,1), 1)
	await get_tree().create_timer(1.0).timeout
	message_bus.GAME_START.emit()
	get_tree().change_scene_to_file("res://World.tscn")
	
	

func _on_button_mouse_entered() -> void:
	$HoverNoise.play()
