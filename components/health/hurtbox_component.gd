class_name HurtboxComponent extends Area2D

@export var health:int = 1

@export var health_component:HealthComponent

func got_hurt(damage_amount:int):
        #if health_component:
                #health_component.got_hurt(damage_amount)
        health -= 1;
        if health <= 0:
                get_parent().call_deferred("die")


#This is a bit rough rm 
