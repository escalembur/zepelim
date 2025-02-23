extends Control

func _ready() -> void:
	get_tree().paused = true

func _on_button_pressed() -> void:
	get_tree().paused = false
	$".".visible = false
