extends Node

@onready var sfx_channel := $AudioStreamPlayer

var interact_parent: Interact
var airship := Global.airship
var delivery_manager := Global.delivery_manager
var sprite : AnimatedSprite2D

func _ready() -> void:
	# Connect to parent interact component
	interact_parent = get_parent()
	interact_parent.interacted.connect(_on_interact)
	sprite = get_node("../../AnimatedSprite2D")


func _on_interact() -> void:
	check_destination()
	sprite.stop()
	sprite.play("default")
	sfx_channel.play()


func check_destination() -> void:
	delivery_manager.attempt_delivery()
