class_name PlayerMeleeCharge extends state


@export var charge_timer:Timer 
@export var melee_cooldown_timer:Timer
@export var melee_attack_line:Line2D
@export var melee_ray:RayCast2D

@export var melee_line_colour:Color

var max_charge_time:int = 1


func _ready() -> void:
        melee_attack_line.default_color = melee_line_colour
        charge_timer.timeout.connect(_on_melee_charge_timer_timeout)

func Enter():
        enable_melee_line()
        charge_timer.start(max_charge_time)

func physics_update(_delta:float):
        controller.velocity = Vector2.ZERO

        controller._look_at_mouse_pos(melee_ray)
        update_melee_line()

        charge()

func charge():
        if Input.is_action_just_released("melee"):
                Transitioned.emit(self, &"playerMelee")

func enable_melee_line():
        melee_attack_line.add_point(Vector2(0,0))
        melee_attack_line.add_point(Vector2(0,0))
func disable_melee_line():
       melee_attack_line.set_point_position(1, Vector2(0,0))
       melee_attack_line.set_point_position(1, Vector2(0,0))

func update_melee_line():
        var pos:Vector2 = controller.direction_to_target * 150 # human concession in afallen world 
        melee_attack_line.set_point_position(0, melee_attack_line.to_local(controller.global_position))
        melee_attack_line.set_point_position(1, pos)

func Exit():
        charge_timer.stop()
        disable_melee_line()

func _on_melee_charge_timer_timeout() -> void:
        melee_cooldown_timer.start(controller.melee_cooldown_time)
        Transitioned.emit(self, &"playerWalk")
