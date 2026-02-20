extends CharacterBody2D


@export var speed:int = 300
@export var grapple_pull_force:int = 4000
@export var jump_velocity:float = -400.0

@onready var grapple_wall_checker:RayCast2D = $RayCast2D

var is_free:bool = true

func _physics_process(delta: float) -> void:
    if is_free:
        velocity += get_gravity() * delta

    if Input.is_action_just_pressed("ui_up") and is_on_floor():
        velocity.y = jump_velocity

    var direction := Input.get_axis("ui_left", "ui_right")
    if direction:
        velocity.x = direction * speed
    else:
        velocity.x = move_toward(velocity.x, 0, speed)

    _point_grapple_to_mouse()
    if Input.is_action_just_pressed("grapple"):
        grapple_wall_check()

    move_and_slide()

func _point_grapple_to_mouse():
        grapple_wall_checker.look_at(get_global_mouse_position())
        

func grapple_wall_check():
    if grapple_wall_checker.is_colliding():
        var mouse_position:Vector2 = get_global_mouse_position() 
        _pull_player(mouse_position)

func _pull_player(point:Vector2):
    var direction_to_point:Vector2 = global_position.direction_to(point)
    velocity = direction_to_point * grapple_pull_force
