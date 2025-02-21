extends Control


@export var previous_menu: Control
@export var fullscreen_checkbox: CheckBox
@export var volume_slider: HSlider


func _ready() -> void:
	# Initialize volume slider with current volume
	volume_slider.value = db_to_linear(AudioServer.get_bus_volume_db(0)) * 100
	
	if OS.get_name() == "Web":
		fullscreen_checkbox.visible = false
		return
		
	# Initialize fullscreen checkbox with current state
	fullscreen_checkbox.button_pressed = get_window().mode == Window.MODE_FULLSCREEN


func _on_fullscreen_check_box_toggled(toggled_on: bool) -> void:
	if toggled_on:
		get_window().mode = Window.MODE_FULLSCREEN
	else:
		get_window().mode = Window.MODE_WINDOWED


func _on_volume_slider_value_changed(value: float) -> void:
	# Convert linear 0-100 value to dB scale
	var db_volume = linear_to_db(value / 100)
	AudioServer.set_bus_volume_db(0, db_volume)


func _on_return_button_pressed() -> void:
	# Hide settings menu and show previous menu
	self.visible = false
	if previous_menu:
		previous_menu.visible = true
