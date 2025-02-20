extends Node


@onready var time_manager := Global.time_manager
@onready var delivery_manager := Global.delivery_manager


func _ready() -> void:
	time_manager.out_of_time.connect(_on_game_over)
	delivery_manager.all_deliveries_completed.connect(
		func():  time_manager.out_of_time.emit(true)
	)


func _on_game_over(success: bool) -> void:
	if success:
		print("WIN!!!!")
	else:
		print("looooose :cccccc")
	time_manager.pause()
