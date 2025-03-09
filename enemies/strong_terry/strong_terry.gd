extends Entity

@onready var state_manager:STATE_MANAGER = $state_machine

func _physics_process(delta: float) -> void:
	move_and_slide()
	state_manager.update_physics(deltaTime)
