extends Entity

@export var target:Player

func _ready() -> void:
        $ChaseComponent.target = target
        $DetectionComponent.target_to_be_seen = target
