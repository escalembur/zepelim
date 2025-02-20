extends Label


@onready var time_manager := Global.time_manager


func _ready() -> void:
	_update_time_display(time_manager.start_time)
	time_manager.time_updated.connect(_update_time_display)


func _update_time_display(seconds: float) -> void:
	var minutes := floor(seconds / 60) as int
	var remaining_seconds := int(seconds) % 60
	text = "%02d:%02d" % [minutes, remaining_seconds]
