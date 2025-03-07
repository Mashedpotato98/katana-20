extends state_machine
class_name playerWalk

@export var player:CharacterBody2D 

@export var max_speed:float = 300.0
@export var jump_velocity:float = -400.0

const deceleration:float = 10
const acceleration:float = 10

func physics_update(_delta:float):
	if not player.player.is_on_floor():
		player.velocity += player.get_gravity() * player.deltaTime

	if Input.is_action_just_pressed("ui_up") and player.is_on_floor():
		player.velocity.y = jump_velocity 

	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		player.velocity.x = move_toward(player.velocity.x,max_speed * direction,acceleration)
	else:
		player.velocity.x = move_toward(player.velocity.x,0.0,deceleration)
