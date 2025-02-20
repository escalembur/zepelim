extends Timer

signal time_updated(remaining: float)
signal out_of_time(success: bool)

## In seconds
@export var start_time := 600.0
@export var time_per_delivery := 45.0

var remaining_time: float:
	set(value):
		remaining_time = max(value, 0)
		time_updated.emit(remaining_time)
		if remaining_time <= 0:
			# Check if deliveries were completed before emitting
			var delivery_manager := Global.delivery_manager
			var success = delivery_manager.deliveries_completed >= \
				delivery_manager.required_deliveries
			out_of_time.emit(success)
			stop()


func _init() -> void:
	Global.time_manager = self

func _ready() -> void:
	remaining_time = start_time
	timeout.connect(_on_timer_timeout)
	start()
	Global.delivery_manager.delivery_completed.connect(
		func() : add_time(time_per_delivery)
	)


func add_time(seconds: float) -> void:
	remaining_time += seconds


func _on_timer_timeout() -> void:
	remaining_time -= 1.0


func pause() -> void:
	stop()


func resume() -> void:
	start()
