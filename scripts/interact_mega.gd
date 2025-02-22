class_name Interact
extends Area2D

signal interacted

@onready var player := Global.player
@onready var manager := Global.interact_manager

@export var floor := Global.Floor.GONDOLA

func _on_body_entered(_body) -> void:
	if player.floor == floor:
		manager.register_area(self)
#
#
func _on_body_exited(_body) -> void:
	manager.unregister_area(self)
