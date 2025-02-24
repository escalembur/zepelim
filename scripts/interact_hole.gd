extends Node

var interact_parent: Interact
var sfx_channel : AudioStreamPlayer
@onready var player = Global.player
@onready var airship = Global.airship

var expected_item := "Tape"

@export var sfx_fix : AudioStreamWAV

func _ready() -> void:
	# Connect to parent interact component
	interact_parent = get_parent()
	interact_parent.interacted.connect(_on_interact)
	interact_parent.floor = Global.Floor.HULL
	sfx_channel = get_node("/root/World/SFXFixes")


func _on_interact() -> void:
	if !player.item_carrying: return
	if player.item_carrying.item_name == expected_item:
		get_parent().get_parent().queue_free()
		airship.holes.remove_at(0)
		sfx_channel.stream = sfx_fix
		sfx_channel.play()
