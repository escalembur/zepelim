class_name Player
extends CharacterBody2D

@export var speed := 300.0

@onready var sprite = $AnimatedSprite2D
@onready var manager = Global.interaction_manager

var can_move := true
var direction := Vector2.DOWN
var facing := "down"

var interact_array := []
var item_carrying : Pickable

func _init() -> void:
	Global.player = self


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact"):
		if item_carrying and manager.active_areas.is_empty():
			item_carrying.pick_up()


func _physics_process(_delta):
	if !can_move: return
	# Get input direction (world space)
	var input_direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	# Adjust input direction to ignore parent's rotation:
	var fixed_direction = input_direction.rotated(get_parent().global_rotation)
	
	# Update velocity
	velocity = fixed_direction * speed
	
	# Update facing direction
	facing = get_facing(input_direction)
	
	# Animate the character
	animate()
	
	# Move the character
	move_and_slide()


func get_facing(input_direction) -> String:
	# Return facing direction based on input moviment, return currently if not do input moviment
	if !input_direction.length(): return facing
	
	direction = sign(input_direction)
	sprite.flip_h = direction.x > 0
	if direction.y < 0:
		return "up"
	elif direction.y > 0:
		return "down"
	return "left"


func animate() -> void:
	var anim_string = "walk_" if velocity.length() else "idle_"
	
	if item_carrying:
		anim_string += "carry_"
	
	anim_string += facing
	
	sprite.play(anim_string)
