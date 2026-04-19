extends Area2D

var damage:int 
var damage_multipler:int = 1

func hurt(hurt_box:HurtboxComponent):
        hurt_box.got_hurt(damage * damage_multipler)


func _on_area_entered(area: Area2D) -> void:
        if area is HurtboxComponent:
                area.got_hurt(1)
