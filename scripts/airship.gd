class_name Airship
extends CharacterBody2D

@export_group("Movement")
@export var max_speed_forward: float = 400.0    # Normal speed
@export var slow_speed_multiplier: float = 0.5  # 50% of normal speed
@export var fast_speed_multiplier: float = 1.5  # 150% of normal speed
@export var max_speed_reverse: float = 150.0    # Reverse speed
@export var rotation_speed: float = 1.5         # radians per second
@export var acceleration: float = 200.0         # Acceleration rate
@export var deceleration: float = 300.0         # Deceleration rate

@export_group("Motors")
@export var motors: Array[Motor]                # Assign motors in inspector

@export_group("Sounds")
@export var sfx_airship : Array[AudioStreamWAV]

@onready var sfx_channel := $AudioStreamPlayer

var altitude := 100000.0
var holes: Array[Node2D]

var thrust_levels = [-1, 0, 1, 2, 3]  # Reverse, Stop, Slow, Normal, Fast
var current_thrust_index = 1          # Starts at neutral (0 - Stop)
var current_speed: float = 0.0
var target_speed: float = 0.0
var controlling := false
var thrust_value

func _init() -> void:
	Global.airship = self

func _ready():
	current_thrust_index = thrust_levels.find(0)

func _input(event):
	if controlling:
		var thrust_index = current_thrust_index
		if event.is_action_pressed("ui_up"):
			current_thrust_index = clamp(current_thrust_index + 1, 0, len(thrust_levels) - 1)
			if thrust_index != current_thrust_index:
				var sfx_index = min(current_thrust_index, 2)
				sfx_channel.stream = sfx_airship[sfx_index]
				sfx_channel.play()
		elif event.is_action_pressed("ui_down"):
			current_thrust_index = clamp(current_thrust_index - 1, 0, len(thrust_levels) - 1)
			if thrust_index != current_thrust_index:
				var sfx_index = (2 - min(current_thrust_index, 2)) % 2
				sfx_channel.stream = sfx_airship[sfx_index]
				sfx_channel.play()
		

func _physics_process(delta):
	var rotation_input := 0.0
	if controlling:
		rotation_input = Input.get_axis("ui_left", "ui_right")
	
	# Calculate motor efficiency
	var efficiency = calculate_motor_efficiency()
	altitude -= holes.size() * 10.0 * delta
	
	# Apply efficiency to movement parameters
	var effective_rotation = rotation_speed * efficiency
	var effective_accel = acceleration * efficiency
	var effective_decel = deceleration * efficiency
	
	# Handle rotation
	rotation += rotation_input * effective_rotation * delta
	
	# Calculate movement direction
	var direction = -transform.y
	
	# Update target speed based on thrust level
	thrust_value = thrust_levels[current_thrust_index]
	match thrust_value:
		-1:  # Reverse
			target_speed = -max_speed_reverse * efficiency
		0:   # Stop
			target_speed = 0.0
		1:   # Slow forward
			target_speed = max_speed_forward * slow_speed_multiplier * efficiency
		2:   # Normal forward
			target_speed = max_speed_forward * efficiency
		3:   # Fast forward
			target_speed = max_speed_forward * fast_speed_multiplier * efficiency
	
	# Gradually adjust current speed towards target speed
	var speed_diff = target_speed - current_speed
	var rate = effective_accel if speed_diff > 0 else effective_decel
	current_speed = move_toward(current_speed, target_speed, rate * delta)
	
	# Set velocity and move
	velocity = direction * current_speed
	move_and_slide()

func calculate_motor_efficiency() -> float:
	var dead_motors = 0
	var damaged_motors = 0
	
	for motor in motors:
		if motor.integrety <= 0.0:
			dead_motors += 1
		elif motor.integrety <= 0.5:
			damaged_motors += 1
	
	# Complete failure if all motors are dead
	if dead_motors >= motors.size():
		return 0.0
	
	# 25% reduction per damaged motor
	return max(1.0 - (damaged_motors * 0.25), 0.0)

func add_altitude_damage(amount: float = 0.1):
	for motor in motors:
		motor.integrety = max(motor.integrety - amount, 0.0)
