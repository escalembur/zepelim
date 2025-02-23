extends StaticBody2D

@onready var airship := Global.airship
@onready var panel := $Panel
@onready var lever := $Lever

@export var in_use_texture: Texture2D
@export var out_use_texture: Texture2D

func _process(delta: float) -> void:
	if airship.controlling:
		panel.texture = in_use_texture
	else:
		panel.texture = out_use_texture
	
	lever.frame = 4 - airship.current_thrust_index
