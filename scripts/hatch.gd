extends StaticBody2D

@onready var sprite = $AnimatedSprite2D
@onready var sfx_channel = $AudioStreamPlayer

func _ready() -> void:
	Global.delivery_manager.delivery_completed.connect(
		func() : open_hatch()
	)

func open_hatch():
	set_collision_layer_value(1, true)
	sprite.play("open")
	sfx_channel.play()

func close_hatch():
	set_collision_layer_value(1, false)
	sprite.play_backwards("open")
	sfx_channel.play()
