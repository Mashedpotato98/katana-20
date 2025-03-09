extends state_machine
class_name enemyWander

@export var enemy:CharacterBody2D
@export var wallDetect:RayCast2D
@export var ledgeDetection:RayCast2D

#region movement
var direction:Vector2 = Vector2.RIGHT
@export var speed:int
#endregion

func Enter():
	change_direction()

func physics_update(_delta:float):
	enemy.velocity = direction * speed
	
	raycast_manager()

	enemy.move_and_slide()

func raycast_manager():
	if wallDetect.is_colliding():
		change_direction()

	if !ledgeDetection.is_colliding():
		change_direction()

func change_direction():
	direction.x *= -1
	print(direction)
