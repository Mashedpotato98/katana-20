class_name PlayerMelee extends state

@export var ray:RayCast2D
@export var melee_timer:Timer
@export var melee_cooldown_timer:Timer

@export var melee_speed:int = 1
@export var melee_time:float = 1

func _ready() -> void:
        melee_timer.timeout.connect(_on_melee_timer_timeout)

func Enter():
        melee_timer.start(melee_time)

func physics_update(_delta:float):
        controller.velocity = controller.direction_to_target * melee_speed

func _on_melee_timer_timeout() -> void:
        Transitioned.emit(self, "PlayerWalk")

func Exit():
        melee_cooldown_timer.start(controller.melee_cooldown_time)
        melee_timer.stop()
