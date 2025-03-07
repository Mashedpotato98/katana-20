extends CharacterBody2D

const SPEED = 500.0
const JUMP_VELOCITY = -200.0
const ACCELERATION = 0.1
const DECELERATION = 0.1

@onready var gc:Node2D = $grapple_controller
@onready var crosshair:Sprite2D = $cross_hair

func _physics_process(delta):
	var mouse = get_global_mouse_position()
	crosshair.global_position = gc.target
	gc.look_at(mouse)
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if Input.is_action_just_pressed("ui_up") && (is_on_floor() || gc.launched):
		velocity.y += JUMP_VELOCITY
		gc.retract()
		crosshair.hide()

	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = lerp(velocity.x, SPEED * direction, ACCELERATION)
	else:
		velocity.x = lerp(velocity.x, 0.0, DECELERATION)
	if gc.launched:
		velocity.x = lerp(velocity.x, 1.0, DECELERATION)
		crosshair.show()

	move_and_slide()
