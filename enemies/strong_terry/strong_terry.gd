class_name StrongTerry extends Entity

@export var target:Player

func _ready() -> void:
        $ChaseComponent.target = target

func die():
        queue_free()
