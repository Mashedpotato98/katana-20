class_name PlayerWalk extends state

@export var ray:RayCast2D
@export var melee_cooldown_timer:Timer 

@export var max_speed:float = 300.0
@export var jump_velocity:float = -400.0
@export var melee_cooldown_time:int = 3

const deceleration:float = 10
const acceleration:float = 10

var can_melee:bool #for sure temporary

func Enter():
        can_melee = false
        print("can, at enter: " + str(can_melee)) 
        melee_cooldown_timer.start(melee_cooldown_time)

func physics_update(_delta:float):
        move(_delta)
        melee_attack()

func move(_delta):
        if not controller.is_on_floor():
                controller.velocity += controller.get_gravity() * _delta

        if Input.is_action_just_pressed("ui_up") and controller.is_on_floor():
                controller.velocity.y = jump_velocity

        var direction := Input.get_axis("ui_left", "ui_right")
        if direction:
                controller.velocity.x = move_toward(controller.velocity.x,max_speed * direction,acceleration)
        else:
                controller.velocity.x = move_toward(controller.velocity.x,0.0,deceleration)

func melee_attack():
        controller._look_at_mouse_pos(controller.max_melee_range, ray)
        if Input.is_action_pressed("melee") and can_melee:
                print("can, at pressed: " + str(can_melee)) 
                Transitioned.emit(self, "PlayerMeleeCharge")

func Exit():
        can_melee = false
        melee_cooldown_timer.stop()
        print("can, at exit: " + str(can_melee)) 

func _on_melee_cooldown_timer_timeout() -> void:
        can_melee = true
        print("can, at cooldown timeout: " + str(can_melee)) 
