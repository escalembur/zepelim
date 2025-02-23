extends StaticBody2D

@onready var airship := Global.airship
@onready var sprite := $Sprite2D

@export var in_use_texture: Texture2D
@export var out_use_texture: Texture2D

func _process(delta: float) -> void:
	if airship.controlling:
		sprite.texture = in_use_texture
	else:
		sprite.texture = out_use_texture
