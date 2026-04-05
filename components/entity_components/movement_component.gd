class_name MovementComponent extends Node
 
@export var controller:Entity

var movement_direction:Vector2

var max_speed:int = 300

var acceleration:int = 200
var decceleration:int = 200

var jump_force:float = 3

func _physics_process(delta: float) -> void:
        if not controller.is_on_floor():
                controller.velocity += controller.get_gravity() * delta
        controller.move_and_slide()

func move(_delta:float):
        if movement_direction:
                controller.velocity.x = move_toward(controller.velocity.x, movement_direction.x * max_speed, acceleration * _delta)
        else:
                controller.velocity.x = move_toward(controller.velocity.x, 0.0, decceleration * _delta)

func stop():
        controller.velocity.x = move_toward(controller.velocity.x, 0.0, decceleration)

func jump(_delta:float):
        if controller.is_on_floor():
                controller.velocity.y -= jump_force 

func push(dir:Vector2, force:float):
        controller.velocity = dir * force
