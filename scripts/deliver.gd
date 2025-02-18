extends Node

var interact_parent: Interact
var airship := Global.airship

func _ready() -> void:
	# Connect to parent interact component
	interact_parent = get_parent()
	interact_parent.interacted.connect(_on_interact)


func _on_interact() -> void:
	check_destination()


func check_destination() -> void:
	if airship.global_position.distance_to(airship.destination) <= 30:
		print("Delivery done!")
		airship.destination = Vector2(randf_range(-5000, 5000), randf_range(-5000, 5000))
	else:
		print("Not at the destination...")
