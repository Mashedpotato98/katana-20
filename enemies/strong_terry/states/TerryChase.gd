extends state
class_name TerryChase

@export var movement_component:MovementComponent
@export var chase_component:ChaseComponent
@export var enemy:CharacterBody2D

var speed:int = 10
var jump_force:int = 10

func _ready() -> void:
	movement_component.speed = speed
	movement_component.jump_force = jump_force
	

func physics_update(_delta:float):
	chase_component.get_direction_to_target()
	movement_component.movement_direction = chase_component.direction_to_target
	
	movement_component.move(_delta)
