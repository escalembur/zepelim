extends Control


@export var pause_main_menu: Control
@export var settings_menu: Control
@export var quit_button: Button


func _ready() -> void:
	visible = false
	settings_menu.visible = false
	if OS.get_name() == "Web":
		quit_button.disabled = true

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		visible = true
		get_tree().paused = true
		pause_main_menu.visible = true
		settings_menu.visible = false


func _on_resume_button_pressed() -> void:
	get_tree().paused = false
	visible = false


func _on_settings_button_pressed() -> void:
	pause_main_menu.visible = false
	settings_menu.visible = true


func _on_quit_button_pressed() -> void:
	get_tree().quit()
