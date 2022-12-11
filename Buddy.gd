extends KinematicBody


var talkRange = false
var talked = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _physics_process(delta):
	look_at(get_node("/root/Game/Player").translation, Vector3.UP)
	
	if talkRange && not talked:
		var first_chat = Dialogic.start("Conversation")
		add_child(first_chat)
		talked = true
		
	if talkRange && Global.hasMac:
		var second_chat = Dialogic.start("FinalTalk")
		add_child(second_chat)
		Global.hasMac = false

func makeScore():
	Global.sVisible = true

func _on_Area_body_entered(body):
	if body.name == "Player":
		talkRange = true


func _on_Area_body_exited(body):
	if body.name == "Player":
		talkRange = false
