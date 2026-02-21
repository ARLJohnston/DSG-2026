extends Node2D

#class_name World
# This was breaking stuff for me - Mac Guy

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Avoid the mouse being held hostage by the game when it shouldn't be.
	if get_viewport().gui_is_dragging() or not get_window().has_focus():
		return
	# clamp the mouse to the game world
	_clamp()

func _clamp() -> void:
	var max_x = get_viewport().size.x
	var max_y = get_viewport().size.y
	var min_x = 0
	var min_y = 0
	var mouse_pos = get_global_mouse_position()
	
	# Don't impact the mouse if we're inside the game window already
	if mouse_pos.x > min_x and mouse_pos.x < max_x and mouse_pos.y > min_y and mouse_pos.y < max_y:
		return 
	
	mouse_pos.x = clamp(mouse_pos.x, min_x, max_x)
	mouse_pos.y = clamp(mouse_pos.y, min_y, max_y)
	Input.warp_mouse(mouse_pos)

func _unhandled_input(event):
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_ESCAPE:
			get_tree().quit()
	
