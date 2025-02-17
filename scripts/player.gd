extends CharacterBody2D

@export var speed := 300.0

var can_move := true

func _physics_process(_delta):
	if !can_move: return
	# Get input direction (world space)
	var input_direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	# Adjust input direction to ignore parent's rotation:
	var fixed_direction = input_direction.rotated(get_parent().global_rotation)
	
	# Update velocity
	velocity = fixed_direction * speed
	
	# Move the character
	move_and_slide()
