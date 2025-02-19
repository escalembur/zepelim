extends Label


@onready var delivery_manager := Global.delivery_manager
@onready var airship := Global.airship


func _process(_delta: float) -> void:
	text = str(round(airship.position.distance_to(delivery_manager.current_delivery)))
