extends Node

var interact_parent: Interact
@onready var airship := Global.airship
@onready var player := Global.player

var expected_item := "Wrench"

@export var motor: Motor

func _ready() -> void:
	# Connect to parent interact component
	interact_parent = get_parent()
	interact_parent.interacted.connect(_on_interact)


func _on_interact() -> void:
	if !player.item_carrying: return
	if player.item_carrying.item_name == expected_item:
		motor.fix_motor()
