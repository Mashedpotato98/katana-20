class_name PlayerWalk extends state

@export var movement_component:MovementComponent 
@export var grapple_ray:RayCast2D
@export var melee_cooldown_timer:Timer 
@export var grapple_cooldown_timer:Timer

@export var max_speed:float = 300.0
@export var jump_velocity:float = 400.0

const deceleration:float = 700
const acceleration:float = 500

var can_melee:bool = true #for sure temporary
var can_grapple:bool = true 

func _ready() -> void:
                melee_cooldown_timer.timeout.connect(_on_melee_cooldown_timer_timeout)
                grapple_cooldown_timer.timeout.connect(_on_grapple_cooldown_timer_timeout)
                
                movement_component.acceleration = acceleration
                movement_component.decceleration = deceleration
                movement_component.max_speed = max_speed
                movement_component.jump_force = jump_velocity

func physics_update(_delta:float):
                #%CanGrappleLabel.text = "grapple" + str(can_grapple)
                #%CanMeleeLabel.text = "melee: " + str(can_melee)

                movement(_delta)
                melee_attack()
                grapple()

func movement(_delta:float):
        var input_x:float = Input.get_axis(&"ui_left", &"ui_right")

        movement_component.movement_direction = Vector2(input_x, 0.0)
        movement_component.move(_delta)
        
        if Input.is_action_just_pressed("ui_up"):
                movement_component.jump(_delta)

func melee_attack():
        if Input.is_action_pressed(&"melee") and can_melee:
                can_melee = false
                Transitioned.emit(self, &"PlayerMeleeCharge")

func grapple():
        controller._look_at_mouse_pos( grapple_ray)
        if Input.is_action_just_pressed(&"grapple") and can_grapple: 
                if grapple_ray.is_colliding():
                        can_grapple = false
                        Transitioned.emit(self, &"PlayerGrapple")

func _on_melee_cooldown_timer_timeout() -> void:
        can_melee = true

func _on_grapple_cooldown_timer_timeout():
        can_grapple = true
