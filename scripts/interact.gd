class_name Interact
extends Sprite2D


signal interacted

@export var distance := 32.0
@onready var player := Global.player


func _process(_delta: float) -> void:
	visible = on_range()


func _input(event: InputEvent) -> void:
	if on_range():
		if event.is_action_pressed("interact"):
			interacted.emit()


func on_range() -> bool:
	# Get distance from parent to the player
	if get_parent().global_position.distance_to(player.global_position) <= distance:
		return true
	else:
		return false
