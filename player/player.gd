class_name Player extends Entity

var direction_to_target:Vector2
var target_point:Vector2

@export var melee_cooldown_time:float = 3.0

func _physics_process(delta: float) -> void:
		move_and_slide()

func _look_at_mouse_pos(ray:RayCast2D):
		ray.look_at(get_global_mouse_position())
		target_point = ray.target_position
		direction_to_target = global_position.direction_to(ray.to_global(target_point))
