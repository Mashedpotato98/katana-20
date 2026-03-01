class_name ChaseComponent extends Node

@export var controller:Entity
@export var navigation_agent:NavigationAgent2D
@export var path_calc_timer:Timer

var target:CharacterBody2D
var direction_to_target:Vector2

func _ready() -> void:
        path_calc_timer.timeout.connect(_calc_timer_timeout)
        
        call_deferred("setup")

func setup() -> void:
        await get_tree().physics_frame
        set_target_position(target.global_position)

func get_direction_to_target():
        #if navigation_agent.navigation_finished:
                #return
        
        if target:
                       var next_path_position:Vector2 = navigation_agent.get_next_path_position()
                       
                       direction_to_target =  controller.global_position.direction_to(next_path_position)

func set_target_position(target_pos:Vector2):
        navigation_agent.target_position = target_pos

func _calc_timer_timeout() -> void:
        set_target_position(target.global_position)
