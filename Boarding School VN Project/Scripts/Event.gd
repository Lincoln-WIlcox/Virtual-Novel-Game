extends Node

var character_list = {"Greenie":Vector2(250,300),"Redie":Vector2(650,350)}
onready var dialog_list = [{"speaker":"Greenie","text":"Howdy! Welcome to the underground!\nI'm Greenie. Greenie the green waifu!!", "animations":{"animation":preload("res://Scenes/Test Anim.tscn"),"strength":3,"speed":0.25,"length":2.5}},{"speaker":"Greenie","text":"You're new to the underground, aren'tcha? Golly, you must be so confused.","sprite change" : 1},{"speaker":"Redie","text":"Hows it goin bros, it's PEWDIEPIE back with another loli waifu review.","sprite_change" : {"Greenie" : 0, "Redie" : 1}, "animations":{"Greenie":{"animation":preload("res://Scenes/Test Anim.tscn"),"strength":3,"speed":0.04,"length":0.9},"Redie":{"animation":preload("res://Scenes/Test Anim.tscn"),"strength":3.5,"speed":0.1,"length":4}}}]
var current_dialog = 0
var waiting_for_dialog = true

signal change_text(text)

func _ready():
	connect("change_text",$"Message Box","change_text")
	#checks to see if the characters in character_list match any of the characters in the global character list, if they do, create character drawings for them
	for i in character_list:
		for b in Global.Characters:
			if i == b:
				var new_character = load("res://Scenes/Character Drawing.tscn").instance()
				new_character.character_name = b
				new_character.set_name(b)
				new_character.position.y = character_list[i].y
				new_character.position.x = character_list[i].x
				new_character.texture_list = Global.Characters[b]["spritelist"]
				new_character.change_texture(0)
				add_child(new_character)
	new_dialog(current_dialog)

func _input(event):
	if event.is_action_pressed("Advance") and waiting_for_dialog == false:
		current_dialog += 1
		new_dialog(current_dialog)

func new_dialog(arraynum):
	#dialog is the current dialog entry on the dialog list
	var dialog = dialog_list[arraynum] 
	emit_signal("change_text",dialog["text"])
	var speaker = "none"
	if dialog.has("speaker"):
		speaker = dialog["speaker"]
	#if the current dialog has animations, loop through the characters and check if they are the same as any of the characters in the global character list, and if so, create the animation and add it to that
	if dialog.has("animations"):
		if !dialog["animations"].has("animation"):
			for i in dialog["animations"]:
				for b in character_list:
					if i == b and has_node(b):
						make_new_animation(dialog["animations"][i],i)
		else:
			make_new_animation(dialog["animations"],speaker)
	#same as above but for sprite changing
	if dialog.has("sprite change"):
		if typeof(dialog["sprite change"]) == TYPE_DICTIONARY:
			for i in dialog["sprite change"]:
				for b in character_list:
					if i == b and has_node(b):
						get_node(b).change_picture(dialog["sprite change"][i])
		elif typeof(dialog["sprite change"]) == TYPE_INT:
			if has_node(speaker):
				if get_node(speaker).has_method("change_texture"):
					get_node(speaker).change_texture(dialog["sprite change"])

func make_new_animation(reference,key_name):
	var new_animation = reference["animation"].instance()
	new_animation.strength = reference["strength"]
	new_animation.speed = reference["speed"]
	new_animation.length = reference["length"]
	get_node(key_name).add_child(new_animation)

func on_dialog_over():
	waiting_for_dialog = false
