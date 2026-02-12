extends Node
class_name state

@export var controller:CharacterBody2D

signal Transitioned(state,new_state_name)

func Enter():
	pass

func Exit():
	pass

func update(_delta:float):
	pass

func physics_update(_delta:float):
	pass
