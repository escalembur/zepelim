class_name Player
extends CharacterBody2D

@export var speed := 300.0
@export var floor := Global.Floor.GONDOLA
@export var sfx_steps : Array[AudioStreamWAV]

@onready var sprite = $AnimatedSprite2D
@onready var sfx_channel := $AudioStreamPlayer
@onready var manager = Global.interact_manager

var input_direction := Vector2.ZERO
var fixed_direction := Vector2.ZERO
var can_move := true
var direction := Vector2.DOWN
var facing := "down"

var softlock_prevent : Interact
var item_carrying : Pickable

func _init() -> void:
	Global.player = self

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact"):
		if softlock_prevent && manager.active_areas.find(softlock_prevent) == -1:
			softlock_prevent.interacted.emit()
		if item_carrying and manager.active_areas.is_empty():
			item_carrying.pick_up()

func _physics_process(_delta):
	# Handle character moviment
	moviment()
	# Handle character animation
	animate()
	
func moviment() -> void:
	if !can_move:
		input_direction = Vector2.ZERO
		return
	# Get input direction (world space)
	input_direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	# Adjust input direction to ignore parent's rotation:
	fixed_direction = input_direction.rotated(get_parent().global_rotation)
	
	# Update velocity
	velocity = fixed_direction * speed
	
	# Move the character
	move_and_slide()
	
	# Update facing direction
	facing = get_facing()
	
func get_facing() -> String:
	# Return facing direction based on input moviment,
	# return currently if not do input moviment
	if !input_direction.length(): return facing
	
	# Play step sfx
	if !sfx_channel.playing:
		sfx_channel.stream = sfx_steps.pick_random()
		sfx_channel.play()
	
	# Update for sprite animation
	direction = fixed_direction
	sprite.flip_h = input_direction.x > 0
	if input_direction.y < 0:
		return "up"
	elif input_direction.y > 0:
		return "down"
	return "left"

func animate() -> void:
	var anim_string = "walk_" if input_direction.length() else "idle_"
	
	if item_carrying:
		anim_string += "carry_"
	
	anim_string += facing
	
	sprite.play(anim_string)
