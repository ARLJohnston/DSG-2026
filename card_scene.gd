extends Node2D

func _ready():
	message_bus.ROUND_END.connect(self.queue_free)
	message_bus.ALL_ROUNDS_DONE.connect(self.queue_free)
