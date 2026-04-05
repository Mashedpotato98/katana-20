class_name TerryIdle extends state

@export var ray_component:RayComponent 
@export var player_detect_ray:RayCast2D

func physics_update(_delta:float):
        ray_component.ray_look_at_target(player_detect_ray, controller.target.global_position)
        
        if ray_component.is_collding(player_detect_ray, controller.target):
                Transitioned.emit(self, "TerryChase")
                return
