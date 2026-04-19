class_name TerryAttack extends state

@export var movement_component:MovementComponent
@export var animation_player:AnimationPlayer
@export var hit_box:Area2D 

func Enter():
        if !hit_box.body_entered.is_connected(_body_entered):
                hit_box.body_entered.connect(_body_entered)
        if !hit_box.area_entered.is_connected(_area_entered):
                hit_box.area_entered.connect(_area_entered)
        
        animation_player.play(&"attack")
        await animation_player.animation_finished
        Transitioned.emit(self, "TerryIdle")


func _body_entered(body:Node2D):#NOT being used at the moment, 19-4
        assert(body.has_method("die"))

func _area_entered(area:Area2D):
        if area is HurtboxComponent:
                area.got_hurt(1) #YEAH< ITS A A bit lulu righgt now
