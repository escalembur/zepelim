extends Label

@onready var airship := Global.airship


func _process(delta: float) -> void:
	text = str(airship.altitude)
