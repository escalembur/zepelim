extends Sprite2D

@export var max_altitude_pos: Vector2
@export var min_altitude_pos: Vector2

@onready var airship := Global.airship

var starting_altitude := 0.0

func _ready() -> void:
	position = max_altitude_pos
	starting_altitude = airship.altitude

func _process(delta: float) -> void:
	var altitude = airship.altitude
	# Calculate interpolation factor (0.0 to 1.0)
	var t: float = (starting_altitude - altitude) / starting_altitude
	# Ensure t stays within valid range
	t = clamp(t, 0.0, 1.0)
	# Interpolate and round to nearest whole number
	position = max_altitude_pos.lerp(min_altitude_pos, t).round()
