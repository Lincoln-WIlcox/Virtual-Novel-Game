extends Node

export(float) var strength = 0
export(float) var speed = 0
export(float) var length = 0
var origin
var safe = false

func _ready():
	if not "position" in get_parent() or not "origin" in get_parent():
		Global.show_error("Parent of \"" + name + "\" is missing properties.")
		queue_free()
	else:
		safe = true
		origin = get_parent().position

func anim_over():
	queue_free()