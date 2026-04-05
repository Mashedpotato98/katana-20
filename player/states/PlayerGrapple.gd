class_name PlayerGrapple extends state

@export var move_component:MovementComponent
@export var grapple_ray:RayCast2D 
@export var grapple_collision_check_area:Area2D
@export var grapple_cooldown_timer:Timer
@export var melee_attack_line:Line2D

@export var grapple_pull_force:int = 200
@export var grapple_ray_length:int 

func Enter() -> void:
        if grapple_collision_check_area.body_entered.is_connected(_grapple_collision_body_entered):
                grapple_collision_check_area.body_entered.connect(_grapple_collision_body_entered)
        grapple_ray.target_position = Vector2(grapple_ray_length, 0) 

func physics_update(_delta:float):
        pull_player()
        if Input.is_action_just_released(&"grapple"):
                Transitioned.emit(self, &"PlayerWalk")

func pull_player():
        move_component.push(controller.direction_to_target, grapple_pull_force)

func _grapple_collision_body_entered(body:Node2D):
        if get_parent().current_state == self:
                print("Body entered")
                Transitioned.emit(self, &"PlayerWalk")

func Exit():
        grapple_cooldown_timer.start(controller.grapple_cooldown_time)
        grapple_collision_check_area.body_entered.disconnect(_grapple_collision_body_entered)
