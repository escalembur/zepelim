extends Node


var interact_parent: Interact


func _ready() -> void:
	get_parent().interacted.connect(_on_interact)


func _on_interact() -> void:
	print("Interacted with " + name)
