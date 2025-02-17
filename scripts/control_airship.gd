extends Node


var interact_parent: Interact


func _ready() -> void:
	# Connect to parent interact component
	get_parent().interacted.connect(_on_interact)


func _on_interact() -> void:
	# TODO: Start controlling the airship if interacted
	print("Interacted with " + name)
