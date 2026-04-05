extends Entity

@export var target:Player

func _ready() -> void:
        $ChaseComponent.target = target
