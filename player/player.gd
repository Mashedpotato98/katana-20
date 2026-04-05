class_name Player extends Entity

var direction_to_target:Vector2
var target_point:Vector2

@export var melee_cooldown_time:float = 3.0
@export var grapple_cooldown_time:float = 3.0


func _look_at_mouse_pos(ray:RayCast2D): # not being used for now, I think 
        print("This shoudnt be used, player.gd")
        ray.look_at(get_global_mouse_position())
        target_point = ray.target_position
        direction_to_target = global_position.direction_to(ray.to_global(target_point))

func _on_health_component_killed() -> void:
        get_tree().call_deferred("reload_current_scene")
        return
