class_name DetectionComponent extends Node


@export var detection_ray:RayCast2D 

var target_to_be_seen:Entity

func _ready() -> void:
        pass # Replace with function body.

func _process(delta: float) -> void:
        pass

func can_see() -> bool:
        if not detection_ray.is_colliding():
                return false

        return detection_ray.get_collider() is Player

func ray_look_at_target(target_pos:Vector2):
        detection_ray.look_at(target_pos)
        var target_point = detection_ray.target_position
        var direction_to_target = get_parent().global_position.direction_to(detection_ray.to_global(target_point))
