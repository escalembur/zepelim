class_name Airship
extends CharacterBody2D


# Movement settings
@export var max_speed: float = 300.0
@export var acceleration: float = 200.0
@export var rotation_speed: float = 1.5  # In radians per second
@export var friction: float = 0.85  # Slowing factor when not thrusting

var controlling := false


func _physics_process(delta: float) -> void:
	var rotation_input: float
	var thrust_input: float

	if controlling:
		# Rotation controls
		rotation_input = Input.get_axis("ui_left", "ui_right")
		thrust_input = Input.get_axis("ui_down", "ui_up")
		
	# Thrust controls
	rotation += rotation_input * rotation_speed * delta
	var thrust_direction := Vector2.UP.rotated(rotation)
	
	if thrust_input != 0:
		# Apply acceleration in facing direction (forward/backward)
		velocity += thrust_direction * thrust_input * acceleration * delta
		velocity = velocity.limit_length(max_speed)
	else:
		# Gradually slow down when not thrusting
		velocity *= friction
	
	# Apply movement
	move_and_slide()
