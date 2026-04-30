class_name RayComponent extends Node

@export var controller:CharacterBody2D 

var target_to_be_seen:Entity#not in use
var direction_to_target:Vector2 = Vector2.ZERO
var colliding_at_point:Vector2 = Vector2.ZERO

func is_collding(ray:RayCast2D, can_collide_with:Node2D) -> bool:#Second parameter is not in use
        colliding_at_point = (ray.get_collision_point()) if ray.is_colliding() else ray.to_global(ray.target_position)
        return ray.is_colliding()

func ray_look_at_target(ray:RayCast2D, target_pos:Vector2):
        ray.look_at(target_pos)
        direction_to_target = controller.global_position.direction_to(ray.to_global(ray.target_position))
