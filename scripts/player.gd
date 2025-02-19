class_name Player
extends CharacterBody2D

@export var speed := 300.0

@onready var sprite = $AnimatedSprite2D
@onready var manager = Global.interaction_manager

var can_move := true

var interact_array := []
var item_carrying : Pickable

func _init() -> void:
	Global.player = self


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact"):
		if item_carrying and manager.active_areas.is_empty():
			item_carrying.pick_up()


func _physics_process(_delta):
	if !can_move:
		sprite.stop()
		return
	# Get input direction (world space)
	var input_direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	# Adjust input direction to ignore parent's rotation:
	var fixed_direction = input_direction.rotated(get_parent().global_rotation)
	
	# Update velocity
	velocity = fixed_direction * speed
	
	# Animate the character
	animate(input_direction)
	
	# Move the character
	move_and_slide()


func animate(direction) -> void:
	if !velocity.length():
		sprite.stop()
		return
	
	var anim_string
	if direction.y < 0:
		anim_string = "up"
	elif direction.y > 0:
		anim_string = "down"
	else:
		anim_string = "left"
		sprite.flip_h = direction.x > 0
	sprite.play(anim_string)
