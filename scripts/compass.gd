extends Sprite2D


@onready var needle := $Line2D


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	needle.global_rotation = 0
