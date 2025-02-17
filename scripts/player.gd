extends CharacterBody2D

@export var speed:= 300.0

func _physics_process(_delta):
	# Get input direction
	var input_direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	# Update velocity
	velocity = input_direction * speed
	
	# Move the character
	move_and_slide()
