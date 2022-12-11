extends KinematicBody

onready var Camera = get_node("/root/Game/Player/Camera")

var velocity = Vector3()
var gravity = -9.8
var speed = 0.2
var max_speed = 4
var mouse_sensitivity = 0.002

var deceleration = 5

var input = false

func _ready():
	$AnimationPlayer.play("Idle")

func _physics_process(delta):
	var desired_velocity = get_input() * speed
	
	if Global.hasMac:
		$Root/Skeleton/BoneAttachment/MacGuffin.visible = true
	else:
		$Root/Skeleton/BoneAttachment/MacGuffin.visible = false
	
	if input == false && velocity != Vector3.ZERO:
		var vec = velocity.normalized()
		velocity -= Vector3(vec.x, 0, vec.z) * deceleration * delta
		if sign(vec.x) != sign(velocity.x):
			velocity.x = 0
			print(true)
		if sign(vec.z) != sign(velocity.z):
			velocity.z = 0
	
	velocity.x += desired_velocity.x
	velocity.z += desired_velocity.z
	var current_speed = velocity.length()
	velocity = velocity.normalized() * clamp(current_speed,0,max_speed)
	$AnimationTree.set("parameters/Idle_Run/blend_amount", current_speed/max_speed)
	var ycol = move_and_collide(Vector3(0, velocity.y + gravity * delta, 0), true, true, true)
	if ycol:
		translation.y = ycol.position.y
		velocity.y = 0
	else:
		velocity.y += gravity * delta
	if velocity.x != 0 or velocity.z != 0:
		velocity = move_and_slide(velocity, Vector3.UP, true)



func _unhandled_input(event):
	if event is InputEventMouseMotion:
		rotate_y(-event.relative.x * mouse_sensitivity)
		velocity = velocity.normalized().rotated(Vector3.UP, -event.relative.x * mouse_sensitivity) * velocity.length()

func get_input():
	var input_dir = Vector3()
	input = false
	if Input.is_action_pressed("forward"):
		input = true
		input_dir += -Camera.global_transform.basis.z
	if Input.is_action_pressed("backward"):
		input = true
		input_dir += Camera.global_transform.basis.z
	input_dir = input_dir.normalized()
	return input_dir
 
