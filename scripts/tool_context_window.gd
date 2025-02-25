extends Control

@onready var player := Global.player


func _process(delta: float) -> void:
	if !player.item_carrying || player.item_carrying.item_name == "Lamp":
		visible = false
	else:
		visible = true
