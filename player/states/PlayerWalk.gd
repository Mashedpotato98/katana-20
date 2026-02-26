class_name PlayerWalk extends state

@export var melee_ray:RayCast2D
@export var grapple_ray:RayCast2D
@export var melee_cooldown_timer:Timer 
@export var grapple_cooldown_timer:Timer

@export var max_speed:float = 300.0
@export var jump_velocity:float = -400.0

const deceleration:float = 10
const acceleration:float = 10

var can_melee:bool #for sure temporary
var can_grapple:bool = true

func _ready() -> void:
        melee_cooldown_timer.timeout.connect(_on_melee_cooldown_timer_timeout)
        grapple_cooldown_timer.timeout.connect(_on_grapple_cooldown_timer_timeout)

func Enter():
        print("can, at enter: " + str(can_melee)) 
        
        melee_attack()

func physics_update(_delta:float):
        %CanGrappleLabel.text = "grapple" + str(can_grapple)
        %CanMeleeLabel.text = "melee: " + str(can_melee)
        move(_delta)
        melee_attack()
        grapple()

func move(_delta):
        if not controller.is_on_floor():
                controller.velocity += controller.get_gravity() * _delta

        if Input.is_action_just_pressed(&"ui_up") and controller.is_on_floor():
                controller.velocity.y = jump_velocity

        var direction := Input.get_axis(&"ui_left", &"ui_right")
        if direction:
                controller.velocity.x = move_toward(controller.velocity.x,max_speed * direction,acceleration)
        else:
                controller.velocity.x = move_toward(controller.velocity.x,0.0,deceleration)

func melee_attack():
        #controller._look_at_mouse_pos( melee_ray)
        if Input.is_action_pressed(&"melee") and can_melee:
                print("can, at pressed: " + str(can_melee)) 
                can_melee = false
                Transitioned.emit(self, &"PlayerMeleeCharge")

func grapple():
        controller._look_at_mouse_pos( grapple_ray)
        if Input.is_action_just_pressed(&"grapple") and can_grapple: 
                if grapple_ray.is_colliding():
                        print("grapple can, at pressed : " + str(can_grapple))
                        can_grapple = false
                        Transitioned.emit(self, &"PlayerGrapple")

func Exit():
        #melee_cooldown_timer.stop()
        
        print("can, at exit: " + str(can_melee)) 

func _on_melee_cooldown_timer_timeout() -> void:
        can_melee = true
        
        print("can, at cooldown timeout: " + str(can_melee)) 

func _on_grapple_cooldown_timer_timeout():
        can_grapple = true
        
        print("grapple can, at cooldown timeout: " + str(can_grapple))
