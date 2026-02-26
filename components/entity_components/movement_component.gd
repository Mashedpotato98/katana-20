class_name MovementComponent extends Node
 
@export var controller:Entity

var movement_direction:Vector2
var speed:int = 3
var jump_force:int = 3

func _physics_process(delta: float) -> void:
	if not controller.is_on_floor():
		controller.velocity += controller.get_gravity()

func move(_delta:float):
	controller.velocity = movement_direction * speed
	
	controller.move_and_slide()

func jump(_delta:float):
	controller.velocity.y += jump_force
