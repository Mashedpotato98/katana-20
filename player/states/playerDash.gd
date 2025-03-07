extends state_machine
class_name playerDash

@export var player:CharacterBody2D

func physics_update(_delta:float):
	if Input.is_action_just_released("melee"):
		Transitioned.emit(self,'playerWalk')
