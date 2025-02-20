class_name DeliveryManager
extends Node

signal delivery_available(position: Vector2)
signal delivery_completed()
signal delivery_failed()
signal all_deliveries_completed()

@export var delivery_radius := 64.0
@export var playable_area_extents := Vector2(5000, 5000)  # Max X/Y distance from center
@export var required_deliveries := 5

var current_delivery: Vector2
var deliveries_completed := 0

func _init() -> void:
	Global.delivery_manager = self

func _ready() -> void:
	start_new_delivery()

func start_new_delivery() -> void:
	# Generate random position within square area
	current_delivery = Vector2(
		randf_range(-playable_area_extents.x, playable_area_extents.x),
		randf_range(-playable_area_extents.y, playable_area_extents.y)
	)
	delivery_available.emit(current_delivery)

func attempt_delivery() -> void:
	if current_delivery == Vector2.ZERO:
		return
	
	var airship_pos = Global.airship.global_position
	if airship_pos.distance_to(current_delivery) < delivery_radius:
		deliveries_completed += 1
		delivery_completed.emit()
		
		if deliveries_completed >= required_deliveries:
			all_deliveries_completed.emit()
			current_delivery = Vector2.ZERO
		else:
			start_new_delivery()  # Generate new target immediately
	else:
		delivery_failed.emit()
