class_name PlayerMeleeCharge extends state


@export var charge_timer:Timer 
@export var melee_cooldown_timer:Timer
@export var melee_attack_line:Line2D
@export var melee_ray:RayCast2D
@export var melee_charge_bar:TextureProgressBar

@export var melee_line_colour:Color
@export var melee_ray_length:int

var max_charge_time:int = 30

func _ready() -> void:
        melee_attack_line.default_color = melee_line_colour
        melee_charge_bar.max_value = max_charge_time * 6 # magic number go boo. maybe it works because 60 frames per second?
        melee_ray.target_position = Vector2(melee_ray_length, 0.0)

func Enter():
        if !charge_timer.timeout.connect(_on_melee_charge_timer_timeout):
                charge_timer.timeout.connect(_on_melee_charge_timer_timeout)
        enable_melee_line()
        charge_timer.start(max_charge_time / 10)
        melee_charge_bar.visible = true

func physics_update(_delta:float):
        controller.velocity = Vector2.ZERO

        controller._look_at_mouse_pos(melee_ray)
        #check_ray_colliders()
        charge()
        update_melee_line()
        melee_charge_bar.value += 1

func charge():
        if Input.is_action_just_released("melee"):
                Transitioned.emit(self, &"playerMelee")

func enable_melee_line():
        melee_attack_line.add_point(Vector2(0,0))
        melee_attack_line.add_point(Vector2(0,0))
        melee_attack_line.visible = true
func disable_melee_line():
        melee_attack_line.set_point_position(1, Vector2(0,0))
        melee_attack_line.set_point_position(1, Vector2(0,0))
        melee_attack_line.visible = false

func update_melee_line():
        var pos:Vector2 = controller.direction_to_target * melee_ray_length # human concession in afallen world 
        melee_attack_line.set_point_position(0, melee_attack_line.to_local(controller.global_position))
        melee_attack_line.set_point_position(1, pos)

func check_ray_colliders():
        while melee_ray.is_colliding():
                var collied_with:Node2D = melee_ray.get_collider()
                if collied_with != null and collied_with is Entity:
                        controller.hit_with.append(collied_with)
                        melee_ray.add_exception(collied_with)
                        melee_ray.force_raycast_update()
        print(controller.hit_with)

func Exit():
        charge_timer.stop()
        charge_timer.timeout.disconnect(_on_melee_charge_timer_timeout)
        disable_melee_line()
        melee_charge_bar.visible = false

func _on_melee_charge_timer_timeout() -> void:
        melee_cooldown_timer.start(controller.melee_cooldown_time)
        Transitioned.emit(self, &"playerWalk")
