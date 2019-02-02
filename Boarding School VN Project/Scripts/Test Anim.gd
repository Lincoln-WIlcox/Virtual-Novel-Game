extends "res://Scripts/Animation.gd"

#false is left, true is right
var side = false

func _ready():
	if safe == true:
		$Length.wait_time = length
		$Timer.wait_time = speed
		$Timer.start()
		$Length.start()

func _on_Timer_timeout():
	if side == false:
		get_parent().position.x = origin.x + strength
		side = true
	else:
		get_parent().position.x = origin.x - strength
		side = false

func _on_Length_timeout():
	queue_free()
