extends Node

var interact_parent: Interact
@onready var player := Global.player

@export var hull: Node2D

func _ready() -> void:
	interact_parent = get_parent()
	interact_parent.interacted.connect(_on_interact)
	player.set_collision_mask_value(1, true)
	player.set_collision_mask_value(5, false)
	

func _on_interact() -> void:
	hull.visible = !hull.visible
	if hull.visible:
		player.set_collision_mask_value(1, false)
		player.set_collision_mask_value(5, true)
	else:
		player.set_collision_mask_value(1, true)
		player.set_collision_mask_value(5, false)
