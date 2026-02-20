class_name PlayerMeleeCharge extends state

@export var charge_timer:Timer 

var max_charge_time:int = 1

func Enter():
        charge_timer.start(max_charge_time)

func physics_update(_delta:float):
        controller.velocity = Vector2.ZERO
        charge()

func charge():
        if Input.is_action_just_released("melee"):
                Transitioned.emit(self, "playerMelee")

func Exit():
        charge_timer.stop()

func _on_melee_charge_timer_timeout() -> void:
        Transitioned.emit(self, "playerWalk")
