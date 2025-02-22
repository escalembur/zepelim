class_name InteractionArea
extends Area2D

var interact: Callable = func():
	pass


func _on_body_entered(_body) -> void:
	Global.interaction_manager.register_area(self)


func _on_body_exited(_body) -> void:
	Global.interaction_manager.unregister_area(self)
