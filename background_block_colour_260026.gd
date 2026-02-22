extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var screenDimensions: Vector2 = get_viewport().get_visible_rect().size
	print(screenDimensions.x)
	# set x between -0.125 and 0.125
	print(screenDimensions.y)
	# set y between -0.15 and 0.15 
	var nebula = $Nebula
	nebula.position = Vector2(screenDimensions.x * randfn(0, 0.10), screenDimensions.y * randfn(0, 0.13))
	for i in range(10):
		var copy = $Nebula.duplicate()
		copy.position = Vector2(screenDimensions.x * randfn(0, 0.10), screenDimensions.y * randfn(0, 0.13))
		add_child(copy)
		self.move_child(copy, 0)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
