extends Node

var hasMac = false

var sVisible = false
var score = 0

func _physics_process(delta):
	score += delta

func _unhandled_input(_event):
	if Input.is_action_just_pressed("escape"):
		get_tree().quit()
