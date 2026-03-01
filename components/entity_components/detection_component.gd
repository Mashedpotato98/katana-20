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

        return detection_ray.get_collider() is Player # evaluates if collider is player. 

func ray_look_at_target():
        if target_to_be_seen:
                detection_ray.look_at(target_to_be_seen.global_position)
