class_name TerryAttack extends state

@export var movement_component:MovementComponent
@export var animation_player:AnimationPlayer
@export var hit_box:Area2D 

func Enter():
        if !hit_box.body_entered.is_connected(_body_entered):
                hit_box.body_entered.connect(_body_entered)
        
        animation_player.play(&"attack")
        await animation_player.animation_finished
        Transitioned.emit(self, "TerryIdle")


func _body_entered(body:Node2D):
        assert(body.has_method("die"))
        body.call_deferred("die")
