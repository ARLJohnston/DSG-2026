extends Node

var json_data
var rounds_left: int = 5

var card_scene = preload("res://Card.tscn")
var anubis: Font

func _ready() -> void:
	var file = FileAccess.open("res://decisions.json", FileAccess.READ)
	var json_text = file.get_as_text()
	json_data = JSON.parse_string(json_text)["decisions"]
	file.close()
	anubis = load("res://assets/fonts/anubis-mythical-font/Anubismythicalserif-lxdLy.otf")
	
	# Spawn cards when game starts from main menu
	message_bus.GAME_START.connect(round)
	message_bus.ROUND_END.connect(round)
	
func round() -> void:
	if label:
		label.queue_free()
	if rounds_left <= 0:
		message_bus.ALL_ROUNDS_DONE.emit()
		rounds_left = 5
		return
	
	rounds_left -= 1
	
	create_decision()
	
var label: RichTextLabel = RichTextLabel.new()

func create_decision() -> void:
	var screenDimensions: Vector2 = get_viewport().get_visible_rect().size
	json_data.shuffle()
	var individual_decision = json_data[0]
	
	label = RichTextLabel.new()
	label.add_theme_font_override("normal_font", anubis)
	label.add_theme_font_override("bold_font", anubis)
	label.bbcode_enabled = true
	label.size = Vector2(screenDimensions.x,1000)
	label.position += Vector2(0,0.2*screenDimensions.y)
	label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	label.text = "[color=white]"+individual_decision["summary"]+"[/color]"
	add_child(label)

	var a: Card = create_card(individual_decision["option_a"])
	var b: Card = create_card(individual_decision["option_b"])
	
	#print("a: ", a.card_values)
	#print("b: ", b.card_values)
	# Add child to the scene
	a.position = Vector2(0.25*screenDimensions.x, 300)
	b.position = Vector2(0.75*screenDimensions.x, 300)
	
	add_child(a)
	add_child(b)
	
	json_data.remove_at(0)

func create_card(individual_decision) -> Card:
	var c = card_scene.instantiate().get_node("Card") as Card
	var label: RichTextLabel = c.get_node("CardText")
	c.outcome = individual_decision["outcome"]
	label.bbcode_enabled = true
	var card_text: String = "[color=black]"+individual_decision["text"]+"[/color]"
	
	var decision_values = individual_decision["values"] as Dictionary[String, int]
	for value in decision_values.keys():
		var score: int = decision_values[value]
		
		match value:
			"balance":
				c.card_values[Values.Maat.balance] = score
				card_text += "\n[rainbow][wave amp=50 freq=2]"+stringify(score)+"↔[/wave][/rainbow]" 
			"harmony":
				c.card_values[Values.Maat.harmony] = score
				card_text += "\n[color=black]" +stringify(score)+"☥[/color]"
			"justice":
				c.card_values[Values.Maat.justice] = score
				card_text += "\n[color=black]" +stringify(score)+"❆[/color]"
			"law":
				c.card_values[Values.Maat.law] = score
				card_text += "\n[color=black]" +stringify(score)+"⚖[/color]"
			"morality":
				c.card_values[Values.Maat.morality] = score
				card_text += "\n[color=black]" +stringify(score)+"𓆠[/color]"
			"order":
				c.card_values[Values.Maat.order] = score
				card_text += "\n[color=black]" +stringify(score)+"ℚ[/color]"
			"truth":
				c.card_values[Values.Maat.truth] = score
				card_text += "\n[color=black]" +stringify(score)+"⌆[/color]"

	label.text = card_text
	return c.get_parent()

func stringify(score: int) -> String:
	if score < 0:
		return str(score)
	return "+" + str(score)

# Listeners
