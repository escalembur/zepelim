class_name Pickable
extends Node

@export var sfx_items : Array[AudioStreamWAV]

@onready var player := Global.player

var node2d: Node2D
var sprite2d: Sprite2D
var interact_parent: Interact
var sfx_channel : AudioStreamPlayer
var item_name: String
var picked_up := false
var height := 0.0

func _ready():
	interact_parent = get_parent()
	interact_parent.interacted.connect(_on_interact)
	node2d = get_parent().get_parent()
	sprite2d = node2d.get_node("Item")
	sfx_channel = get_node("/root/World/SFXItems")
	item_name = node2d.name
	if Global.pickables.size() == 3:
		Global.pickables.clear()
	Global.pickables.append(self)


func _physics_process(_delta) -> void:
	if picked_up:
		node2d.global_position = player.global_position
	height = lerp(height, 12.0 * int(picked_up), 0.25)
	sprite2d.offset.y = -7.0 - height


func _on_interact() -> void:
	if player.item_carrying:
		player.item_carrying.pick_up()
	pick_up()


func pick_up() -> void:
	interact_parent.monitoring = picked_up
	picked_up = !picked_up
	if picked_up:
		player.item_carrying = self
		sfx_channel.stream = sfx_items.pick_random()
		sfx_channel.play()
	else:
		player.item_carrying = null
		node2d.global_position += player.direction
