extends KinematicBody2D

const FRICTION = 500
const ACCELERATION = 500
const MAX_SPEED = 80

var velocity = Vector2.ZERO
var animation_direction = Vector2.ZERO

onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")

func _ready():
	animationTree.active = true

func _physics_process(delta):
	move(delta)

func move(delta):
	var mouse_pos = get_local_mouse_position()
	var look = Vector2(mouse_pos.x,mouse_pos.y)
	
	var input_vector = Vector2.ZERO

	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	
	animationTree.set("parameters/Idle/blend_position", look)
	animationTree.set("parameters/Move/blend_position", look)

	if input_vector != Vector2.ZERO:
		animationTree.set("parameters/Idle/blend_position", look)
		animationTree.set("parameters/Move/blend_position", look)
		animationState.travel("Move")
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)		
	else:
		animationState.travel("Idle")
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)	
		
	velocity = move_and_slide(velocity)	

