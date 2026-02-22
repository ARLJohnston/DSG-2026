extends Node2D
	
var anubis: Font

func _ready() -> void:
	# Do some calculations [bbtext]
	
	var score = global_score.game_score
	var truth = score.get(Values.Maat.truth, 0)
	var balance =  score.get(Values.Maat.balance,0)
	var order = score.get(Values.Maat.order, 0)
	var harmony = score.get(Values.Maat.harmony, 0)
	var law = score.get(Values.Maat.law, 0)
	var morality = score.get(Values.Maat.morality, 0)
	var justice = score.get(Values.Maat.justice, 0)
	
	var qualified_endings : Dictionary[int,String] = {
		0 : "You lived a life upholding the letter of the law, yet it betrays you in the end....",
		1 : "You lived a selfless life. Cherished by the living, remembered in death...",
		2 : "You upheld some virtues, yet you never upheld yourself to the same standard...",
		3 : "You decieved yourself to achieve a state of happiness that you knew was a lie...",
		4 : "Your lived your life in misery as a result of your own actions...",
		5 : "You lived a life without regard for the rules yet you always chased fulfillment...",
		6 : "You lived a selfish life and so, you are alone...",
		7 : "You upheld the spirit of the law even if you had to break it a few times...",
		8 : "Your actions were deemed insignificant, [fade]you will be forgotten by the sands of time...[/fade]",
		9 : "Your actions were deemed exceptional. You have been granted entry into the Fields of Aaru...",
		10: "You were judged unworthy. Your heart has been devoured by Ammit, never to be reborn again...",
	}
	
	var ending_text 
	
	if law > 3 and order > 3 and justice < -2: ending_text = qualified_endings[0]
	elif morality > 3 and harmony > 3 and balance > 3: ending_text = qualified_endings[1]
	elif truth > 3 and justice > 3 and balance < -3: ending_text = qualified_endings[2]
	elif truth < -3 and harmony > 4: ending_text = qualified_endings[3]
	elif truth > 4 and harmony < -2 and order < -2: ending_text = qualified_endings[4]
	elif law < -2 and order < -2 and justice < -2 : ending_text = qualified_endings[5]
	elif morality < -4 and truth < -4: ending_text = qualified_endings[6]
	elif justice > 4 and truth > 4 and law < -2: ending_text = qualified_endings[7]
	else:
		var sum_val = 0
		for x in score.values(): sum_val += x
		if sum_val >= -1 and sum_val <= 1: ending_text = qualified_endings[8]
		elif sum_val < -1: ending_text = qualified_endings[10]
		elif sum_val > 1: ending_text = qualified_endings[9]
	
	print(ending_text)
	var vp: Vector2 = get_viewport().get_visible_rect().size
	var fadedMessage = RichTextLabel.new()
	anubis = load("res://assets/fonts/anubis-mythical-font/Anubismythicalserif-lxdLy.otf")
	fadedMessage.add_theme_font_override("normal_font", anubis)
	fadedMessage.add_theme_font_override("bold_font", anubis)
	fadedMessage.bbcode_enabled = true
	fadedMessage.size = Vector2(vp.x,1000)
	fadedMessage.text = "[color=white]" + ending_text + "[/color]"
	fadedMessage.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	fadedMessage.custom_minimum_size = Vector2(300, 100)
	fadedMessage.z_index = 1
	fadedMessage.z_as_relative = false
	fadedMessage.position += Vector2(0,0.2*vp.y)
	add_child(fadedMessage)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		get_tree().change_scene_to_file("res://MainMenu.tscn")
