extends Entity

@export var target:Player

func _ready() -> void:
        if not target:
                assert(target)
        $ChaseComponent.target = target
