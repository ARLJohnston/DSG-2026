extends Sprite2D

func _ready() -> void:
	var screenDimensions: Vector2 = get_viewport().get_visible_rect().size
	self.position = Vector2(screenDimensions.x/2, 0.9*screenDimensions.y)
