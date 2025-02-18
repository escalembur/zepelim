extends Label


@onready var airship := Global.airship


func _process(_delta: float) -> void:
	text = str(round(airship.position.distance_to(airship.destination)))
