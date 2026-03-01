class_name TerryIdle extends state

@export var detection_component:DetectionComponent 

func physics_update(_delta:float):
        detection_component.ray_look_at_target()
        
        if detection_component.can_see():
                Transitioned.emit(self, "TerryChase")
