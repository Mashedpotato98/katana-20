extends CharacterBody2D


@export var max_speed:float = 300.0
@export var jump_velocity:float = -400.0

const deceleration:float = 0.1
const acceleration:float = 0.1

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		velocity.y = jump_velocity

	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = lerp(velocity.x,max_speed * direction,acceleration)
	else:
		velocity.x = lerp(velocity.x,0.0,deceleration)

	move_and_slide()
