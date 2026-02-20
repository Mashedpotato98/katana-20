class_name Player extends Entity

var direction_to_target:Vector2

@export var max_grapple_range:int = 50
@export var max_melee_range:int = 50

func _physics_process(delta: float) -> void:
        move_and_slide()

func _look_at_mouse_pos(range:int, ray:RayCast2D):
        var ray_to_mouse:Vector2 = ray.global_position.direction_to(ray.get_global_mouse_position())
        ray.target_position = ray_to_mouse * max_melee_range
        direction_to_target = global_position.direction_to(get_global_mouse_position())
