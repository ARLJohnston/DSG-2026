extends Area2D

#var dragging
#
#func _input(event: InputEvent) -> void:
	#var card: Node2D = self.get_parent().get_node("Card")
	#if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		#if $CollisionShape2D.shape.get_rect().has_point(get_local_mouse_position()):
			#if event.pressed:
				#dragging = true
			#else:
				#dragging = false
#
	#if event is InputEventMouseButton and event.is_released(): # AND DRAGGING
		#var tween = get_tree().create_tween()
		#tween.tween_property(card, "position", Vector2(0,0),0.1).set_ease(Tween.EASE_OUT)
