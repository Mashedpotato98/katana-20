class_name PlayerGrapple extends state

@export var move_component:MovementComponent
@export var ray_component:RayComponent
@export var grapple_ray:RayCast2D 
@export var grapple_collision_check_area:Area2D
@export var grapple_cooldown_timer:Timer
@export var melee_attack_line:Line2D

@export var grapple_pull_force:int = 100
@export var shimmy_speed:int = 15000
@export var grapple_ray_lengthnotused:int 

func Enter() -> void:
        move_component.max_speed = shimmy_speed
        move_component.acceleration = shimmy_speed
        if !grapple_collision_check_area.body_entered.is_connected(_grapple_collision_body_entered):
                grapple_collision_check_area.body_entered.connect(_grapple_collision_body_entered)

func physics_update(_delta:float):
        pull_player()
        #horizontal_motion(_delta)
        if Input.is_action_just_released(&"grapple"):
                Transitioned.emit(self, &"PlayerWalk")

func pull_player():
        move_component.push(ray_component.direction_to_target, grapple_pull_force)

func horizontal_motion(_delta: float):
        var input_x:float = Input.get_axis(&"ui_left", &"ui_right")
        
        move_component.movement_direction = Vector2(input_x, 0.0)
        move_component.move(_delta)


func _grapple_collision_body_entered(body:Node2D):
        if get_parent().current_state == self:
                #print("Body entered, player_graple.gd")
                Transitioned.emit(self, &"PlayerWalk")

func Exit():
        grapple_cooldown_timer.start()
        grapple_collision_check_area.body_entered.disconnect(_grapple_collision_body_entered)
