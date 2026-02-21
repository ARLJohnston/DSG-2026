extends Node

var json_data

var card_scene = preload("res://Card.tscn")

func _ready() -> void:
	var file = FileAccess.open("res://decisions.json", FileAccess.READ)
	var json_text = file.get_as_text()
	json_data = JSON.parse_string(json_text)["decisions"]
	file.close()
	create_decision()

func create_decision() -> void:
	# TODO: once we have enough decisions, remove them after we use them :)
	var individual_decision = json_data.pick_random()
	
	var a: Card = create_card(individual_decision["option_a"])
	var b: Card = create_card(individual_decision["option_b"])
	
	print("a: ", a.card_values)
	print("b: ", b.card_values)
	# Add child to the scene
	a.position = Vector2(250, 300)
	b.position = Vector2(750, 300)
	
	add_child(a)
	add_child(b)


				
func create_card(individual_decision) -> Card:
	# Make this instantiate, generates whole thing vs just instance of script
	var c = card_scene.instantiate()
	var label = Label.new()
	label.text = individual_decision["text"]
	label.add_theme_color_override("font_color", Color())
	
	label.set_position(Vector2(0,50))
	
	# Add to card_scene instead so it's visible
	c.add_child(label)
	var decision_values = individual_decision["values"] as Dictionary[String, int]
	for value in decision_values.keys():
		var score: int = decision_values[value]
		match value:
			"balance":
				c.card_values[Values.Maat.balance] = score
			"harmony":
				c.card_values[Values.Maat.harmony] = score
			"justice":
				c.card_values[Values.Maat.justice] = score
			"law":
				c.card_values[Values.Maat.law] = score
			"morality":
				c.card_values[Values.Maat.morality] = score
			"order":
				c.card_values[Values.Maat.order] = score
			"truth":
				c.card_values[Values.Maat.truth] = score
	return c
