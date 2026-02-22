extends Node2D

var base_font_size = 16

func _ready():
	message_bus.ROUND_END.connect(self.queue_free)
	message_bus.ALL_ROUNDS_DONE.connect(self.queue_free)

	auto_fit_font()

# Font fix - Start big, make smaller until it fits in card.
func auto_fit_font():
	var label = $Card/CardText
	var font_size = 24
	var min_size = 8

	while font_size > min_size:
		label.add_theme_font_size_override("normal_font_size", font_size)
		label.add_theme_font_size_override("bold_font_size", font_size)
		label.get_content_height()
		# Check if text fits within the label's rect
		if label.get_content_height() <= label.size.y:
			break
		font_size -= 1
