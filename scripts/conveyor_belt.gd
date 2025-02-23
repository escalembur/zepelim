extends Node2D

@onready var path = $Path2D/PathFollow2D

@export var package_scene : PackedScene

var packages := []
var all_deliveries_completed := false

func _ready() -> void:
	Global.delivery_manager.delivery_completed.connect(
		func() : drop_package()
	)
	Global.delivery_manager.all_deliveries_completed.connect(
		func() : all_deliveries_completed = true
	)

func _process(_delta) -> void:
	if !all_deliveries_completed && path.progress_ratio < 1.0:
		path.progress_ratio = min(path.progress_ratio + 0.02, 1.0)
	
	if packages.size():
		var index = 0
		while index < packages.size():
			if packages[index] == null:
				packages.remove_at(index)
				continue
			index += 1
		
		if packages.is_empty():
			get_node("../DeliveryHatch").close_hatch()

func drop_package() -> void:
	var package = package_scene.instantiate()
	package.position += Vector2(-40, 21)
	$".".add_child(package)
	packages.append(package)
	path.progress_ratio = 0.0
