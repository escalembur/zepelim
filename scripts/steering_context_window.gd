extends Control


@onready var player := Global.player


func _process(delta: float) -> void:
	# This shouldn't be in in process, but it's fine for now
	if player.can_move:
		visible = false
	else:
		visible = true
