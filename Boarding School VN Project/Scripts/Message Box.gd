extends CanvasLayer

onready var text_label = $MainContainer/InsideContainer/RichTextLabel
export(String, MULTILINE) var display_text

signal dialog_over

func _ready():
	connect("dialog_over",get_parent(),"on_dialog_over")
	text_label.visible_characters = 1
	$MainContainer/InsideContainer/RichTextLabel.text = display_text

func change_text(dialog_text):
	$AnimationPlayer.stop(true)
	$"Continue Symbol".hide()
	text_label.visible_characters = 1
	text_label.text = dialog_text
	$"Character Timer".start()

func _on_Character_Timer_timeout():
	if text_label.visible_characters < text_label.text.length() - 1:
		if text_label.text[text_label.visible_characters] == "?" or text_label.text[text_label.visible_characters] == "." or text_label.text[text_label.visible_characters] == "!" or text_label.text[text_label.visible_characters] == ",":
			text_label.visible_characters += 1
			$"Character Timer".stop()
			$"Punctuation Timer".start()
		else:
			text_label.visible_characters += 1
	else:
		text_label.visible_characters += 1
		$"Character Timer".stop()
		$"Punctuation Timer".stop()
		$AnimationPlayer.play("flashing thing")
		emit_signal("dialog_over")


func _on_Punctuation_Timer_timeout():
	text_label.visible_characters += 1
	$"Character Timer".start()
	$"Punctuation Timer".stop()
