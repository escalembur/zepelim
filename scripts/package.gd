extends Sprite2D

func _process(_delta) -> void:
	position = position.lerp(Vector2(-61, 25), 0.15)
	scale = scale.lerp(Vector2.ZERO, 0.02)
	
	if scale.x < 0.1:
		queue_free()
