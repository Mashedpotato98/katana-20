class_name playerDashCharge extends state

@export var chargeTimer:Timer 

var max_charge_time:int = 1

func Enter():
	chargeTimer.start(max_charge_time)
	chargeTimer.timeout.connect(_ChargeTimerTimeout)

func physics_update(_delta:float):
	pass

func charge():
	if Input.is_action_just_released("melee"):
		controller.direction_to_mouse = controller.global_position.direction_to(controller.get_global_mouse_position())

func Exit():
	chargeTimer.stop()

func _ChargeTimerTimeout():
	Transitioned.emit(self, "playerWalk")
