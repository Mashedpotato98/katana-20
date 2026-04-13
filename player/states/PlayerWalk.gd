class_name PlayerWalk extends state

@export var movement_component:MovementComponent 
@export var ray_component:RayComponent
@export var grapple_ray:RayCast2D
@export var melee_cooldown_timer:Timer 
@export var grapple_cooldown_timer:Timer
@export var melee_cooldown_bar:ProgressBar
@export var grapple_cooldown_bar:ProgressBar

@export var max_speed:float = 300.0
@export var jump_velocity:float = 400.0

const deceleration:float = 700
const acceleration:float = 500

func Enter() -> void:
        if !melee_cooldown_timer.timeout.is_connected(_on_melee_cooldown_timer_timeout):
                melee_cooldown_timer.timeout.connect(_on_melee_cooldown_timer_timeout)
        if !grapple_cooldown_timer.timeout.is_connected(_on_grapple_cooldown_timer_timeout):
                grapple_cooldown_timer.timeout.connect(_on_grapple_cooldown_timer_timeout)

        movement_component.acceleration = acceleration
        movement_component.decceleration = deceleration
        movement_component.max_speed = max_speed
        movement_component.jump_force = jump_velocity

        %CrossHair.visible = true
        melee_cooldown_bar.max_value = melee_cooldown_timer.wait_time
        grapple_cooldown_bar.max_value = grapple_cooldown_timer.wait_time

func physics_update(_delta:float):
                #%CanGrappleLabel.text = "grapple" + str(can_grapple)
                #%CanMeleeLabel.text = "melee: " + str(can_melee)

                movement(_delta)
                melee_attack()
                grapple()
                hud()

func movement(_delta:float):
        var input_x:float = Input.get_axis(&"ui_left", &"ui_right")

        movement_component.movement_direction = Vector2(input_x, 0.0)
        movement_component.move(_delta)
        
        if Input.is_action_just_pressed("ui_up"):
                movement_component.jump(_delta)

func melee_attack():
        if Input.is_action_pressed(&"melee") and can_melee():
                Transitioned.emit(self, &"PlayerMeleeCharge")
                return

func grapple():
        ray_component.ray_look_at_target(grapple_ray, controller.get_global_mouse_position())
        %CrossHair.global_position = grapple_ray.to_global(grapple_ray.target_position) #crosshair will be at end of ray
        if Input.is_action_just_pressed(&"grapple") and can_grapple(): 
                if grapple_ray.is_colliding():
                        Transitioned.emit(self, &"PlayerGrapple")
                        return

func hud():
        melee_cooldown_bar.value = melee_cooldown_timer.time_left
        grapple_cooldown_bar.value = grapple_cooldown_timer.time_left

func can_grapple() -> bool:
        if grapple_cooldown_timer.time_left > 0.0:
                return false
        return true

func can_melee():
        if melee_cooldown_timer.time_left > 0:
                return false
        return true

func Exit():
        #melee_cooldown_timer.timeout.disconnect(_on_melee_cooldown_timer_timeout)
        #grapple_cooldown_timer.timeout.disconnect(_on_melee_cooldown_timer_timeout)
        %CrossHair.visible = false

func _on_melee_cooldown_timer_timeout() -> void:
        print("melee cooldown timer time, player_walk.gd")

func _on_grapple_cooldown_timer_timeout():
        print("grapple cooldown timer time, player_walk.gd")
