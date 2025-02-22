class_name HullManager
extends Node2D

signal hole_warning

@onready var bound : Rect2 = $CollisionShape2D.shape.get_rect()
@onready var hole := preload("res://scenes/hole.tscn")
var timer := 60

func _process(_delta) -> void:
	if timer > 0:
		timer -= 1
	else:
		timer = 60
		_generate_hole()

func _generate_hole() -> void:
	var min_bound = bound.position
	var max_bound = bound.end
	var point_x = randf_range(min_bound.x, max_bound.x)
	var point_y = randf_range(min_bound.y, max_bound.y)
	var new_hole = hole.instantiate()
	new_hole.global_position = Vector2(point_x, point_y)
	add_child(new_hole)
	hole_warning.emit()
