class_name HealthComponent extends Node2D

signal hit
signal killed

var max_health:int 
var current_health:int 

func got_hurt(damage:int):
        current_health -= damage

        if current_health <= 0:
                killed.emit()
