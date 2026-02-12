class_name playerWalk extends state

#@export var sword_ray:RayCast2D

#region movement variables
@export var max_speed:float = 300.0
@export var jump_velocity:float = -400.0

const deceleration:float = 10
const acceleration:float = 10

func physics_update(_delta:float):
	move(_delta)

func move(_delta):
	if not controller.is_on_floor():
		controller.velocity += controller.get_gravity() * _delta
		print("Gravity:"+ str(get_gravity()))
		print("delta:" + str(_delta))

	if Input.is_action_just_pressed("ui_up") and controller.is_on_floor():
		controller.velocity.y = jump_velocity

	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		controller.velocity.x = move_toward(controller.velocity.x,max_speed * direction,acceleration)
	else:
		controller.velocity.x = move_toward(controller.velocity.x,0.0,deceleration)

func _melee_check():
	if (Input.is_action_pressed("melee")):
		Transitioned.emit(self, "playerDashCharge")
