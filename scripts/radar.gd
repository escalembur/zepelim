extends Sprite2D

@onready var airship := Global.airship
@onready var pointer := $Node2D

func _process(_delta: float) -> void:
	# Calculate direction from airship to destination
	var direction = airship.global_position - airship.destination
	if direction.length_squared() > 0:
		# Calculate the angle and adjust for the compass's initial north orientation
		var angle = direction.angle() - PI/2
		pointer.global_rotation = angle
