extends Label


@onready var delivery_manager := Global.delivery_manager


func _ready() -> void:
	_update_label()
	delivery_manager.delivery_completed.connect(_update_label)


func _update_label() -> void:
	text = str(delivery_manager.deliveries_completed) + "/" + str(delivery_manager.required_deliveries)
