extends Area2D

var dragging: bool
var snap_reference

func _ready():
	snap_reference = self.get_parent().get_parent().get_children()[1] # Area2D2
	print(snap_reference.position)
	
func _input(event: InputEvent) -> void:
	var card: Node2D = self.get_parent()
	
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if $CollisionShape2D.shape.get_rect().has_point(get_local_mouse_position()):
			if event.pressed:
				dragging = true
			else:
				dragging = false

	if event is InputEventMouseMotion and dragging: # AND DRAGGING
		var tween = get_tree().create_tween()
		tween.tween_property(card, "global_position", event.position,0.1).set_ease(Tween.EASE_OUT)
	
	elif not dragging and event.is_released():
		var tween = get_tree().create_tween()
		tween.tween_property(card, "position", snap_reference.position,0.1).set_ease(Tween.EASE_OUT)
