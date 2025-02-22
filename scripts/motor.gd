class_name Motor
extends StaticBody2D

var integrety := 1.0
@onready var sprite := $Sprite2D
@onready var smoke := $SmokeAnimation

@export var fixed_texture: Texture2D
@export var broken_texture: Texture2D

func _process(delta: float) -> void:
	integrety -= 0.5 * delta
	if integrety > 0.5:
		sprite.texture = fixed_texture
		smoke.visible = false
	else:
		sprite.texture = broken_texture
		smoke.visible = true


func fix_motor() -> void:
	if integrety <= 1:
		integrety += 1.0
