class_name PlayerMeleeCharge extends state

@export var charge_timer:Timer 
@export var melee_cooldown_timer:Timer

@export var melee_ray:RayCast2D
@export var ray_component:RayComponent

@export var melee_attack_line:Line2D
@export var melee_charge_bar:TextureProgressBar

@export var melee_line_colour:Color

var max_charge_time:int = 30

var colour:Color = Color(255,255,0)

#region de/initial

func _ready() -> void:
        melee_attack_line.default_color = melee_line_colour
        melee_charge_bar.max_value = max_charge_time * 6 # magic number go boo. maybe it works because 60 frames per second?

        melee_attack_line.add_point(Vector2(0,0))
        melee_attack_line.add_point(Vector2(0,0))


func Enter():
        if !charge_timer.timeout.is_connected(_on_melee_charge_timer_timeout):
                #print(charge_timer.timeout.get_connections() + ", melee_Chgarge.gd")
                charge_timer.timeout.connect(_on_melee_charge_timer_timeout)
        enable_hud()
        change_game_speed(0.1)

func Exit():
        charge_timer.stop()
        charge_timer.timeout.disconnect(_on_melee_charge_timer_timeout)
        disable_melee_line()
        melee_cooldown_timer.start() #This timer will be used in plyr_walk
        change_game_speed(1.0)

#endregion

func physics_update(_delta:float):
        controller.velocity = Vector2.ZERO

        charge_mechanics()
        update_hud()

func charge_mechanics():
        ray_component.ray_look_at_target(melee_ray, controller.get_global_mouse_position())
        if Input.is_action_just_released(&"melee"): #and not ray_component.is_collding(melee_ray, null):
                Transitioned.emit(self, &"playerMelee")

#region melee_visuals
func enable_hud():
        melee_charge_bar.value = 0 #0 is rhe default value 
        melee_charge_bar.visible = true
        charge_timer.start(max_charge_time / 10)

        melee_attack_line.visible = true

func disable_melee_line():
        melee_attack_line.set_point_position(1, Vector2(0,0))
        melee_attack_line.set_point_position(1, Vector2(0,0))
        melee_attack_line.visible = false

        melee_charge_bar.visible = false

func update_hud():
        var pos:Vector2 = ray_component.direction_to_target * melee_ray.target_position.x
        melee_attack_line.set_point_position(0, melee_attack_line.to_local(controller.global_position))
        melee_attack_line.set_point_position(1, pos)
        melee_attack_line.default_color = colour
        
        melee_charge_bar.value += 1

#endregion


#region signals 

func _on_melee_charge_timer_timeout() -> void:
        Transitioned.emit(self, &"playerWalk")

func check_ray_colliders(): # I dont think this is in use
        while melee_ray.is_colliding():
                var collied_with:Node2D = melee_ray.get_collider()
                if collied_with != null and collied_with is Entity:
                        controller.hit_with.append(collied_with)
                        melee_ray.add_exception(collied_with)
                        melee_ray.force_raycast_update()

func change_game_speed(time_scale:float):
        Engine.time_scale = time_scale

#endregion
