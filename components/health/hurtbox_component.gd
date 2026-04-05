class_name HurtboxComponent extends Area2D


@export var health_component:HealthComponent

func got_hurt(damage_amount:int):
        if health_component:
                health_component.got_hurt(damage_amount)
