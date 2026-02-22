extends AnimatedSprite2D
@onready var animated_sprite_2d: AnimatedSprite2D = $"."


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animated_sprite_2d.play("default")
	message_bus.ROUND_END.connect(flare)
	
func flare() -> void:
	animated_sprite_2d.play("flare")
	await get_tree().create_timer(1.6).timeout
	animated_sprite_2d.play("default")
