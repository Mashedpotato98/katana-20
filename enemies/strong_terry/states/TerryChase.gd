class_name TerryChase extends EnemyChase

@export var movement_component:MovementComponent
@export var hit_box:Area2D

func Enter() -> void:
        if !hit_box.body_entered.is_connected(_player_close):
                #print("YO, terry_chase.gd")
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
        Transitioned.emit(self, "TerryAttack")
        return 
