class_name PlayerMelee extends state

@export var move_component:MovementComponent
@export var ray_component:RayComponent 

@export var melee_area:Area2D
@export var wall_collision:Area2D # I might be able to use one area for both melee+wall detection but seems risky
@export var melee_collision:CollisionShape2D
@export var melee_ray:RayCast2D 

@export var melee_timer:Timer
@export var melee_cooldown_timer:Timer

@export var melee_force:float = 1000

var tween:Tween = null #testing

func Enter():
        move_component.decceleration = 10

        if !melee_timer.timeout.is_connected(_on_melee_timer_timeout):
                melee_timer.timeout.connect(_on_melee_timer_timeout)
        if !melee_area.body_entered.is_connected(_on_melee_body_entered):
                melee_area.body_entered.connect(_on_melee_body_entered)
        if !wall_collision.body_entered.is_connected(_on_collided_wall):
                wall_collision.body_entered.connect(_on_collided_wall)

        melee_collision.disabled = false

        melee_timer.start()
        #move_component.push(ray_component.direction_to_target, melee_force)
        tween_move()

func physics_update(_delta:float):
        #move_component.stop()
        pass

func _on_melee_timer_timeout() -> void:
        #controller.velocity = Vector2.ZERO
        Transitioned.emit(self, &"PlayerWalk")
        return

func _on_melee_body_entered(body: Node2D):
        if body is StrongTerry:
                body.call_deferred("queue_free")
                return

func _on_collided_wall(body:Node2D):
        Transitioned.emit(self, &"PlayerWalk")

func Exit():
        controller.velocity = Vector2.ZERO
        print("exit, melee.gd")
        melee_cooldown_timer.start()
        
        melee_area.body_entered.disconnect(_on_melee_body_entered)
        wall_collision.body_entered.disconnect(_on_collided_wall)

        melee_timer.stop()
        melee_collision.call_deferred("disabled", true)


func tween_move():
        if tween:
                tween.kill()
        
        tween = create_tween()
        tween.set_trans(Tween.TRANS_QUAD)
        tween.set_ease(Tween.EASE_IN_OUT)
        tween.tween_property(controller, "velocity", ray_component.direction_to_target * melee_force, 0.5)
      ## YEAH YEAH< I KNOW. MGIC NUMBERS< ITS TEMPORRAORY. GOT IT ?

      
