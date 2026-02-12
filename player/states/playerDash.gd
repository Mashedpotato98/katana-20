class_name playerDash extends state

@export var ray:RayCast2D
@export var maximum_pull_force:int

func Enter():
	controller.velocity = controller.direction_to_mouse * maximum_pull_force
