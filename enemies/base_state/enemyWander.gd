extends state
class_name enemyWander

@export var enemy:CharacterBody2D
@export var wallDetect:RayCast2D
@export var ledgeDetection:RayCast2D

#region movement
var direction:Vector2 = Vector2.RIGHT
@export var speed:int
#endregion

func physics_update(_delta:float):
	enemy.velocity = direction * speed
	
	raycast_manager()

	enemy.move_and_slide()

func raycast_manager():
	if wallDetect.is_colliding():
		change_direction()
		print('1')

	if not ledgeDetection.is_colliding():
		change_direction()
		print('2')

func change_direction():
	if direction == Vector2.RIGHT:
		direction = Vector2.LEFT
		enemy.scale.x = -1
	elif direction == Vector2.LEFT:
		direction = Vector2.RIGHT
		enemy.scale.x = 1
