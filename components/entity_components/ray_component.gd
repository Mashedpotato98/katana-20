class_name RayComponent extends Node

@export var controller:CharacterBody2D 

var target_to_be_seen:Entity
var direction_to_target:Vector2 = Vector2.ZERO

func is_collding(ray:RayCast2D, can_collide_with:Node2D) -> bool:
        if not ray.is_colliding():
                return false

        return ray.get_collider().is_class(can_collide_with.get_class())

func ray_look_at_target(ray:RayCast2D, target_pos:Vector2):
        ray.look_at(target_pos)
        direction_to_target = controller.global_position.direction_to(target_pos)
