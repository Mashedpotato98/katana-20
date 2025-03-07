extends CharacterBody2D
class_name Entity

var deltaTime:float = 0.0
var time_scale:float = 1

@onready var state_machine:STATE_MANAGER = $state_machine

func _physics_process(delta: float) -> void:
	deltaTime = delta * 1
	state_machine.update_physics(deltaTime)
	move_and_slide()
