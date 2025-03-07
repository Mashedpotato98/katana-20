extends state_machine
class_name playerWalk

#region movement variables
@export var player:CharacterBody2D 
@export var grapple_gun:Node2D

@export var max_speed:float = 300.0
@export var jump_velocity:float = -400.0

const deceleration:float = 10
const acceleration:float = 10
#endregion

#region melee variables
var time_held_down:float = 0.0
var hold_threshold:float = 1.0
var has_transitioned:bool = false
#endregion

func Enter():
	grapple_gun.process_mode = Node.PROCESS_MODE_INHERIT

func physics_update(_delta:float):
	move(_delta)
	melee(_delta)

func move(_delta):
	if not player.is_on_floor():
		player.velocity += player.get_gravity() * _delta

	if Input.is_action_just_pressed("ui_up") and player.is_on_floor():
		player.velocity.y = jump_velocity

	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		player.velocity.x = move_toward(player.velocity.x,max_speed * direction,acceleration)
	else:
		player.velocity.x = move_toward(player.velocity.x,0.0,deceleration)

func melee(_delta):
	if Input.is_action_pressed("melee") and not has_transitioned:
		time_held_down += _delta  

	if time_held_down > hold_threshold and not has_transitioned:
		grapple_gun.process_mode = Node.PROCESS_MODE_DISABLED
		Transitioned.emit(self, "playerDash")
		has_transitioned = true  

	if Input.is_action_just_released("melee"):
		time_held_down = 0.0  
		has_transitioned = false  
