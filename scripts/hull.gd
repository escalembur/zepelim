extends Sprite2D

@export var spawn_scene: PackedScene
@export var spawn_rate: float = 1.0
@export var position_snap: float = 1.0  # Set to 1 for whole numbers, 0.5 for half-tiles, etc.

@onready var spawn_timer = $Timer
@onready var collision_polygon = $StaticBody2D/CollisionPolygon2D

var rng = RandomNumberGenerator.new()

func _ready():
	rng.randomize()
	if spawn_timer:
		spawn_timer.wait_time = spawn_rate
		spawn_timer.timeout.connect(_on_timer_timeout)
		spawn_timer.start()
	else:
		push_error("Timer node not found!")

func _on_timer_timeout():
	spawn()
	print("Timer triggered - new instance spawned")

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		spawn()
		print("Manual spawn triggered")

func spawn():
	if !spawn_scene:
		push_error("No spawn scene assigned!")
		return
	
	var polygon = collision_polygon.polygon
	if polygon.size() < 3:
		push_error("Invalid spawn area polygon!")
		return
	
	# Calculate polygon bounds
	var min_point = Vector2.INF
	var max_point = -Vector2.INF
	for point in polygon:
		min_point = min_point.min(point)
		max_point = max_point.max(point)
	
	# Find valid spawn point
	var local_point: Vector2
	var found = false
	for attempt in 100:
		local_point = Vector2(
			rng.randf_range(min_point.x, max_point.x),
			rng.randf_range(min_point.y, max_point.y)
		)
		
		if Geometry2D.is_point_in_polygon(local_point, polygon):
			found = true
			break
	
	if !found:
		push_error("Failed to find valid spawn point")
		return
	
	# Convert and round position
	var global_spawn_pos = collision_polygon.transform * local_point
	global_spawn_pos = global_spawn_pos.snapped(Vector2(position_snap, position_snap))
	
	# Create instance
	var new_instance = spawn_scene.instantiate()
	new_instance.position = global_spawn_pos
	Global.airship.holes.append(new_instance)
	$".".add_child(new_instance)
	print("Spawned at: ", global_spawn_pos)
