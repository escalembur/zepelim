extends Sprite2D

@onready var airship := Global.airship
@onready var delivery_manager := Global.delivery_manager
@onready var pointer := $Node2D
@onready var sprite := $Node2D/Sprite2D

var sprite_start_pos 
var is_flashing := false
var flash_timer := 0.0
var original_color: Color

func _ready() -> void:
	sprite_start_pos = sprite.position
	original_color = sprite.modulate  # Store original color

func _process(delta: float) -> void:
	# Calculate direction from airship to destination
	var direction = airship.global_position - delivery_manager.current_delivery
	var distance = airship.position.distance_to(delivery_manager.current_delivery)
	
	if direction.length_squared() > 0:
		# Calculate the angle and adjust for the compass's initial north orientation
		var angle = direction.angle() - PI/2
		pointer.global_rotation = angle
	
	# Distance-based Y position and flashing
	var min_distance = 64.0
	var max_distance = 640.0
	
	if distance > min_distance:
		# Normal distance behavior
		var clamped_distance = clamp(distance, min_distance, max_distance)
		var t = (clamped_distance - min_distance) / (max_distance - min_distance)
		var new_y = lerp(0.0, -6.0, t)
		sprite.position = Vector2(sprite_start_pos.x, new_y)
		
		# Reset flashing if we were previously flashing
		if is_flashing:
			is_flashing = false
			sprite.modulate = original_color
	else:
		# Start flashing when close
		is_flashing = true
		sprite.position = Vector2(sprite_start_pos.x, 0.0)
		
		# Calculate flashing effect using sine wave
		flash_timer += delta * 8  # Adjust speed with multiplier
		var alpha = abs(sin(flash_timer))
		sprite.modulate = original_color.lerp(Color.RED, alpha)

	# Reset timer when not flashing to prevent large numbers
	if not is_flashing:
		flash_timer = 0.0
