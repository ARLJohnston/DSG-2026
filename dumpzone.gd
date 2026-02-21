extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_area_entered(obj):
	if obj.is_in_group("droppable"):
		print("in drop area")
		
func _on_area_exited(obj):
	if obj.is_in_group("droppable"):
		print("out of drop area")
