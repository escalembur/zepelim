extends Node

var interact_parent: Interact
@onready var player := Global.player
@onready var pickables := Global.pickables
@onready var hull : Node2D = get_node("../../../Hull")

func _ready() -> void:
	interact_parent = get_parent()
	interact_parent.interacted.connect(_on_interact)
	player.set_collision_mask_value(1, true)
	player.set_collision_mask_value(5, false)
	

func _on_interact() -> void:
	hull.visible = !hull.visible
	if hull.visible:
		player.set_collision_mask_value(1, false)
		player.set_collision_mask_value(5, true)
		player.floor = Global.Floor.HULL
	else:
		player.set_collision_mask_value(1, true)
		player.set_collision_mask_value(5, false)
		player.floor = Global.Floor.GONDOLA
	
	interact_parent.floor = player.floor
	
	for pickable in pickables:
		if player.item_carrying == pickable:
			pickable.interact_parent.floor = player.floor
		else:
			var on_same_floor = pickable.interact_parent.floor == player.floor
			pickable.interact_parent.monitoring = on_same_floor
			pickable.node2d.visible = on_same_floor
