extends Node

export(Dictionary) var Characters = {"Greenie" : {"relationship" : 50, "spritelist" : ["res://Assets/VN test pictures/expression 1 green.png","res://Assets/VN test pictures/expression 2 green.png"]},
                                     "Redie"   : {"relationship" : 50, "spritelist" : ["res://Assets/VN test pictures/expression 1 red.png","res://Assets/VN test pictures/expression 2 red.png"]}}

export(Dictionary) var Animations = {"test anim" : "res://Scenes/Test Anim.tscn"}

func show_error(message):
	print("We encountered a problem: " + message)
	pass