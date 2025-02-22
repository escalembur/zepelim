extends Node

var interact_parent: Interact

func _ready() -> void:
	interact_parent = get_parent()
	interact_parent.interacted.connect(_on_interact)


func _on_interact() -> void:
	get_parent().get_parent().queue_free()
