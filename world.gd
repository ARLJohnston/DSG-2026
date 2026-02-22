extends Node2D

var fadedMessage: RichTextLabel
var faded: bool = false
var anubis: Font
#class_name World
# This was breaking stuff for me - Mac Guy
func fade_in() -> void:
	var fade_in_box = create_tween()
	fade_in_box.tween_property($Fade, "color", Color(0, 0, 0, 0), 1)
	if fadedMessage:
		fadedMessage.queue_free()
	faded = false
	
func fade_out(msg: String) -> void:
	print("fading out")
	var fade_in_box = create_tween()
	fade_in_box.tween_property($Fade, "color", Color(0, 0, 0, 1), 1)
	if msg != "":
		var vp: Vector2 = get_viewport().get_visible_rect().size
		fadedMessage = RichTextLabel.new()
		fadedMessage.add_theme_font_override("normal_font", anubis)
		fadedMessage.add_theme_font_override("bold_font", anubis)
		fadedMessage.bbcode_enabled = true
		fadedMessage.text = "[color=white]" + msg + "[/color]"
		fadedMessage.custom_minimum_size = Vector2(300, 100)
		fadedMessage.position = (vp / 2) - (fadedMessage.custom_minimum_size / 2)
		fadedMessage.z_index = 10
		fadedMessage.z_as_relative = false
		fadedMessage.y_sort_enabled = true
		add_child(fadedMessage)
		faded = true
	else:
		await get_tree().create_timer(1.0).timeout
		message_bus.FADE_IN.emit()
	
func set_ended():
	if get_tree():
		get_tree().change_scene_to_file("res://ending.tscn")
		queue_free()

	
func _ready() -> void:
	
	fade_in()
	anubis = load("res://assets/fonts/anubis-mythical-font/Anubismythicalserif-lxdLy.otf")
	
	message_bus.FADE_IN.connect(fade_in)
	message_bus.FADE_OUT.connect(fade_out)
	message_bus.ALL_ROUNDS_DONE.connect(set_ended)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Avoid the mouse being held hostage by the game when it shouldn't be.
	if get_viewport().gui_is_dragging() or not get_window().has_focus():
		return
	# clamp the mouse to the game world
	_clamp()

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and faded:
		fade_in()
	
		
	#if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and ended:
	#	fade_in()
	#	get_tree().change_scene_to_file("res://MainMenu.tscn")

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
	
