extends Node2D
	
var anubis: Font

func end():
	# Do some calculations
	var vp: Vector2 = get_viewport().get_visible_rect().size
	var fadedMessage = RichTextLabel.new()
	anubis = load("res://assets/fonts/anubis-mythical-font/Anubismythicalserif-lxdLy.otf")
	fadedMessage.add_theme_font_override("normal_font", anubis)
	fadedMessage.add_theme_font_override("bold_font", anubis)
	fadedMessage.bbcode_enabled = true
	fadedMessage.text = "[color=white]" + "This game is [rainbow][wave]over![/wave][/rainbow]" + "[/color]"
	fadedMessage.custom_minimum_size = Vector2(300, 100)
	fadedMessage.position = (vp / 2) - (fadedMessage.custom_minimum_size / 2)
	add_child(fadedMessage)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		get_tree().change_scene_to_file("res://MainMenu.tscn")
