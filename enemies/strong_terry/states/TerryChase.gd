class_name TerryChase extends state

@export var movement_component:MovementComponent
@export var ray_component:RayComponent
@export var chase_component:ChaseComponent
@export var enemy:CharacterBody2D
@export var hit_box:Area2D

@export var speed:int = 500
@export var jump_force:int = 450
@export var acceleration:int = 450
@export var deacceleration:int = 300


func Enter() -> void:
        movement_component.max_speed = speed
        movement_component.jump_force = jump_force
        movement_component.acceleration = acceleration
        movement_component.decceleration = deacceleration

        if !hit_box.body_entered.is_connected(_player_close):
                print("YO")
                hit_box.body_entered.connect(_player_close)

func physics_update(_delta:float):
        #if not detection_component.can_see():
                #Transitioned.emit(self, "TerryIdle")
                #return

        chase_component.get_direction_to_target()
        movement_component.movement_direction = chase_component.direction_to_target
        
        movement_component.move(_delta)

func Exit():
        movement_component.stop()

func _player_close(body:Node2D):
        Transitioned.emit(self, "PlayerAttack")
