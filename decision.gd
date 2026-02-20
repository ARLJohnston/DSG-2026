extends Node

var json_data

func _ready() -> void:
	var file = FileAccess.open("res://decisions.json", FileAccess.READ)
	var json_text = file.get_as_text()
	json_data = JSON.parse_string(json_text)["decisions"]
	file.close()

func create_decision() -> void:
	# TODO: once we have enough decisions, remove them after we use them :)
	var individual_decision = json_data.pick_random()
	
	var a: Card = create_card(individual_decision["option_a"])
	var b: Card = create_card(individual_decision["option_b"])
	print("a: ", a.card_values)
	print("b: ", b.card_values)
	# Add child to the scene


				
func create_card(individual_decision) -> Card:
	var c: Card = Card.new()
	#var label = Label.new()
	#label.text = individualDecision["text"]
	#print(individualDecision["text"])
	#label.set_position(Vector2(600,300))
	#add_child(label)
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
