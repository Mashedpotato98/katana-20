extends Node2D


@export var rest_length = 2.0
@export var stiffness = 10.0
@export var damp = 1.0

@onready var player:CharacterBody2D = get_parent()
@onready var ray:RayCast2D = $RayCast2D
@onready var rope:Line2D = $Line2D

var launched = false
var target: Vector2

func _process(delta):
	   
	if Input.is_action_just_pressed("grapple"):
		launch()
	if Input.is_action_just_released("grapple"):
		retract()
	
	if launched:
		handle_grapple(delta)

func launch():
	if ray.is_colliding():
		launched = true
		target = ray.get_collision_point()
		rope.show()

func retract():
	launched = false
	rope.hide()

func handle_grapple(delta):
	var target_dir = player.global_position.direction_to(target)
	var target_dist = player.global_position.distance_to(target)
	
	var displacement = target_dist - rest_length
	
	var force = Vector2.ZERO
	
	if displacement > 0:
		var spring_force_magnitude = stiffness * displacement
		var spring_force = target_dir * spring_force_magnitude
		
		var vel_dot = player.velocity.dot(target_dir)
		var damping = -damp * vel_dot * target_dir
		
		force = spring_force + damping
	
	player.velocity += force * delta
