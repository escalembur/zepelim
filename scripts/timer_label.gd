extends Label


func _ready() -> void:
	Global.time_manager.time_updated.connect(_update_time_display)


func _update_time_display(seconds: float) -> void:
	var minutes := floor(seconds / 60) as int
	var remaining_seconds := int(seconds) % 60
	text = "%02d:%02d" % [minutes, remaining_seconds]
