extends Node2D


@export var rest_length:float = 1.0
@export var stiffness:float = 30.0
@export var damp:float = 20.0

@onready var player:CharacterBody2D = get_parent()
@onready var ray:RayCast2D = $RayCast2D
@onready var rope:Line2D = $Line2D

var launched:bool = false
var target: Vector2

func _draw() -> void:
        draw_line(position,target,Color.ALICE_BLUE)

func _process(delta):
           
        if Input.is_action_just_pressed("grapple"):
                launch()
        if Input.is_action_just_released("grapple"):
                retract()
        
        if launched:
                handle_grapple(delta)

func launch():
        if ray.is_colliding():
                queue_redraw()
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
        update_rope()

func update_rope():
        rope.set_point_position(0, to_local(target))
