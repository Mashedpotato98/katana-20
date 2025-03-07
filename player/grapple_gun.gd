extends Node2D

@onready var player:CharacterBody2D = $".."
@onready var ray:RayCast2D = $RayCast2D
@onready var cross:Sprite2D = $"../Crosshair"

var launched:bool = false
var target_position:Vector2

@export var grapple_force:int 

func _process(delta: float) -> void:
	if launched == false:
		handle_ray_mouse()

	if Input.is_action_pressed("grapple") and ray.is_colliding():
		while launched == false:
			launched = true
			get_target()

	if launched == true:
		grapple_handle()

	if Input.is_action_just_released('grapple'):
		launched = false

func get_target():
	target_position = ray.get_collision_point()

func grapple_handle():
		var direction:Vector2 = player.position.direction_to(target_position).normalized()
		player.velocity = direction * grapple_force

func handle_ray_mouse():
	look_at(get_global_mouse_position())
	cross.global_position = get_global_mouse_position()
	cross.global_position.limit_length(200)
