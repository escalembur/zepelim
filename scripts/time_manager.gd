extends Timer

signal time_updated(remaining: float)
signal time_out()

@export var start_time: float = 480.0  # 8 minutes in seconds

var remaining_time: float:
	set(value):
		remaining_time = max(value, 0)
		time_updated.emit(remaining_time)
		if remaining_time <= 0:
			time_out.emit()
			stop()


func _init() -> void:
	Global.time_manager = self


func _ready() -> void:
	remaining_time = start_time
	timeout.connect(_on_timer_timeout)
	start()

func add_time(seconds: float) -> void:
	remaining_time += seconds

func _on_timer_timeout() -> void:
	remaining_time -= 1.0

func pause() -> void:
	stop()

func resume() -> void:
	start()
