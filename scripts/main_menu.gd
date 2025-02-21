extends Control


@export var game_scene: PackedScene
@export var quit_button: Button

@onready var main_menu := $MainMenu
@onready var settings_menu := $SettingsMenu


func _ready() -> void:
	main_menu.visible = true
	settings_menu.visible = false
	
	if OS.get_name() == "Web":
		quit_button.disabled = true


func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_packed(game_scene)


func _on_settings_button_pressed() -> void:
	main_menu.visible = false
	settings_menu.visible = true


func _on_quit_button_pressed() -> void:
	get_tree().quit()
