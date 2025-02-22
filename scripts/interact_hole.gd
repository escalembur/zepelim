extends Node

var interact_parent: Interact
@onready var player = Global.player

var expected_item := "Tape"

func _ready() -> void:
	# Connect to parent interact component
	interact_parent = get_parent()
	interact_parent.interacted.connect(_on_interact)
	interact_parent.floor = Global.Floor.HULL


func _on_interact() -> void:
	if !player.item_carrying: return
	if player.item_carrying.item_name == expected_item:
		get_parent().get_parent().queue_free()
