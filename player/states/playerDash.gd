extends state_machine
class_name playerDash

@export var player:CharacterBody2D
@export var ray:RayCast2D

@export var maximum_pull_force:int

var target:Vector2
var released:bool = false

func physics_update(_delta:float):
	var mouse:Vector2 = ray.to_local(player.get_global_mouse_position())
	ray.target_position = mouse.limit_length(maximum_pull_force)

	if released == true and player.position.distance_to(target) < 5:
		Transitioned.emit(self,'playerWalk')

	if Input.is_action_just_released("melee") and released == false:
		dash()

func dash():
	released = true
	target = ray.to_global(ray.target_position)
	print(ray.target_position)
	print(target)
	var direction:Vector2 = player.position.direction_to(target).normalized()
	player.velocity = direction * 200
