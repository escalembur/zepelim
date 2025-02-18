class_name Airship
extends CharacterBody2D

@export var max_speed_forward: float = 400.0
@export var max_speed_reverse: float = 200.0
@export var rotation_speed: float = 1.5  # radians per second
@export var acceleration: float = 200.0  # Acceleration rate when speeding up
@export var deceleration: float = 300.0  # Deceleration rate when slowing down

var thrust_levels = [-2, -1, 0, 1, 2]
var current_thrust_index = 2  # Starts at neutral (0)
var current_speed: float = 0.0
var target_speed: float = 0.0
var controlling := false

func _init() -> void:
	Global.airship = self

func _ready():
	current_thrust_index = thrust_levels.find(0)

func _input(event):
	if controlling:
		if event.is_action_pressed("ui_up"):
			current_thrust_index = clamp(current_thrust_index + 1, 0, len(thrust_levels) - 1)
		elif event.is_action_pressed("ui_down"):
			current_thrust_index = clamp(current_thrust_index - 1, 0, len(thrust_levels) - 1)

func _physics_process(delta):
	var rotation_input := 0.0
	if controlling:
		rotation_input = Input.get_axis("ui_left", "ui_right")
	
	# Handle rotation
	rotation += rotation_input * rotation_speed * delta
	
	# Calculate movement direction
	var direction = -transform.y
	
	# Update target speed based on thrust level
	var thrust_value = thrust_levels[current_thrust_index]
	match thrust_value:
		2: target_speed = max_speed_forward
		1: target_speed = max_speed_forward * 0.5
		0: target_speed = 0.0
		-1: target_speed = -max_speed_reverse * 0.5
		-2: target_speed = -max_speed_reverse
	
	# Gradually adjust current speed towards target speed
	var speed_diff = target_speed - current_speed
	var rate = acceleration if speed_diff > 0 else deceleration
	current_speed = move_toward(current_speed, target_speed, rate * delta)
	
	# Set velocity and move
	velocity = direction * current_speed
	move_and_slide()
