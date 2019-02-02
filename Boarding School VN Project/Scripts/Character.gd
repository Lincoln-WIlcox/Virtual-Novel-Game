extends Node2D

export(int) var playerrep
onready var origin = position
export(String) var character_name
var texture_list

func _ready():
	if character_name == null:
		pass

func change_texture(imagenumber):
	$Sprite.texture = load(texture_list[imagenumber])
	pass

func play_animation(animation):
	pass

func new_turn():
	pass