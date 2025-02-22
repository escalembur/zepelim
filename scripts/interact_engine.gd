extends Node

var interact_parent: Interact
var airship := Global.airship
@export var motor: Motor

func _ready() -> void:
	# Connect to parent interact component
	interact_parent = get_parent()
	interact_parent.interacted.connect(_on_interact)


func _on_interact() -> void:
	motor.fix_motor()
