class_name PlayerMelee extends state

@export var move_component:MovementComponent
@export var melee_area:Area2D
@export var melee_collision:CollisionShape2D
@export var ray:RayCast2D
@export var melee_timer:Timer
@export var melee_cooldown_timer:Timer

@export var melee_force:int = 1
@export var melee_time:float = 1

func _ready() -> void:
        melee_timer.timeout.connect(_on_melee_timer_timeout)
        melee_area.body_entered.connect(_on_melee_body_entered)

func Enter():
        melee_collision.disabled = false
        melee_timer.start(melee_time)

func physics_update(_delta:float):
        move_component.push(controller.direction_to_target, melee_force)

func _on_melee_timer_timeout() -> void:
        controller.velocity = Vector2.ZERO
        Transitioned.emit(self, "PlayerWalk")
        return

func _on_melee_body_entered(body: Node2D):
        body.call_deferred("queue_free")

func Exit():
        #for i:Entity in controller.hit_with:
                #i.call_deferred("queue_free")
#
        melee_cooldown_timer.start(controller.melee_cooldown_time)
        
        melee_area.body_entered.disconnect(_on_melee_body_entered)

        melee_timer.stop()
        melee_collision.disabled = true
        #return
