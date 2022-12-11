extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _physics_process(delta):
	if not Global.sVisible:
		$Label.text = "Score: " + str(Global.score)
	visible = Global.sVisible
