extends CharacterBody2D


@export var max_speed:float = 300.0
@export var jump_velocity:float = -400.0

const deceleration:float = 10
const acceleration:float = 10

const time_scale:float = 0.5

var deltaTime:float = 0.0

@onready var state_machine:STATE_MANAGER = $state_machine

func _physics_process(delta: float) -> void:
	deltaTime = delta * time_scale
	state_machine.update_physics(deltaTime)

func player(delta):
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		velocity.y = jump_velocity

	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = move_toward(velocity.x,max_speed * direction,acceleration)
	else:
		velocity.x = move_toward(velocity.x,0.0,deceleration)

	if Input.is_action_pressed('melee'):
		while max_speed != max_speed * delta:
			max_speed *= delta
			print(max_speed)

	if Input.is_action_just_released('melee'):
		max_speed = 300
		print(max_speed)
		
	#velocity.x = move_toward()
	move_and_slide()
