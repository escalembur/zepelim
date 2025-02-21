extends Control


@export var pause_main_menu: Control
@export var settings_menu: Control

@export var main_menu: PackedScene


func _ready() -> void:
	visible = false
	settings_menu.visible = false

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		visible = !visible
		pause_main_menu.visible = true
		settings_menu.visible = false


func _on_resume_button_pressed() -> void:
	visible = false


func _on_settings_button_pressed() -> void:
	pause_main_menu.visible = false
	settings_menu.visible = true


func _on_menu_button_pressed() -> void:
	get_tree().change_scene_to_packed(main_menu)


func _on_quit_button_pressed() -> void:
	get_tree().quit()
