extends CharacterBody2D

const SPEED = 500.0
const JUMP_VELOCITY = -200.0
const ACCELERATION = 0.1
const DECELERATION = 0.1

@onready var gc := $grapple_controller

func _physics_process(delta):
	gc.look_at(get_global_mouse_position())
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if Input.is_action_just_pressed("ui_up") && (is_on_floor() || gc.launched):
		velocity.y += JUMP_VELOCITY
		gc.retract()
	
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = lerp(velocity.x, SPEED * direction, ACCELERATION)
	else:
		velocity.x = lerp(velocity.x, 0.0, DECELERATION)
	if gc.launched:
		velocity.x = lerp(velocity.x, 5.0, DECELERATION)

	move_and_slide()
