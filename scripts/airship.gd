class_name Airship
extends CharacterBody2D

@export_group("Movement")
@export var max_speed_forward := 400.0
@export var max_speed_reverse := 200.0
@export var rotation_speed := 1.5
@export var acceleration := 200.0
@export var deceleration := 300.0
@export var altitude_loss_speed := 50.0

var thrust_levels = [-2, -1, 0, 1, 2]
var current_thrust_index = 2
var current_speed: float = 0.0
var target_speed: float = 0.0
var controlling := false
var thrust_value

# Damage system variables
var holes_in_envelope := 0
var motor_damage := 1.0  # Range: 0.0 (no damage) to 1.0 (complete failure)

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
	
	# Calculate effective movement parameters based on motor damage
	var effective_max_forward = max_speed_forward * (1 - motor_damage)
	var effective_max_reverse = max_speed_reverse * (1 - motor_damage)
	var effective_rotation = rotation_speed * (1 - motor_damage)
	var effective_accel = acceleration * (1 - motor_damage)
	var effective_decel = deceleration * (1 - motor_damage)
	
	# Handle rotation
	rotation += rotation_input * effective_rotation * delta
	
	# Calculate movement direction
	var direction = -transform.y
	
	# Update target speed based on thrust level
	thrust_value = thrust_levels[current_thrust_index]
	match thrust_value:
		2: target_speed = effective_max_forward
		1: target_speed = effective_max_forward * 0.5
		0: target_speed = 0.0
		-1: target_speed = -effective_max_reverse * 0.5
		-2: target_speed = -effective_max_reverse
	
	# Gradually adjust current speed towards target speed
	var speed_diff = target_speed - current_speed
	var rate = effective_accel if speed_diff > 0 else effective_decel
	current_speed = move_toward(current_speed, target_speed, rate * delta)
	
	# Calculate movement velocity and add altitude loss
	var movement_velocity = direction * current_speed
	var altitude_velocity = Vector2.DOWN * holes_in_envelope * altitude_loss_speed
	velocity = movement_velocity + altitude_velocity
	
	move_and_slide()

# Repair functions
func repair_hole():
	holes_in_envelope = max(holes_in_envelope - 1, 0)

func repair_motor(repair_amount: float):
	motor_damage = clamp(motor_damage - repair_amount, 0.0, 1.0)

# Damage functions
func add_hole():
	holes_in_envelope += 1

func damage_motor(damage_amount: float):
	motor_damage = clamp(motor_damage + damage_amount, 0.0, 1.0)
