class_name HitboxComponent extends Area2D

var damage:int 
var damage_multipler:int = 1

func _ready() -> void:
        area_entered.connect(_on_area_enter)

func hurt(hurt_box:HurtboxComponent):
        hurt_box.got_hurt(damage * damage_multipler)


func _on_area_enter(area: Area2D) -> void:
        if area is HurtboxComponent:
                print("This should never happen - fix it.exe, hitbox.gd")
                area.got_hurt(1)
