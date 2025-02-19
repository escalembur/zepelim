class_name Pickable
extends Node2D

@onready var player := Global.player
@onready var area: InteractionArea = $Interact
@onready var offset = $Item.offset.y

var picked_up := false
var height := 0.0


func _ready():
	area.interact = Callable(self, "_on_interact")


func _physics_process(_delta) -> void:
	if picked_up:
		global_position = player.global_position
	height = lerp(height, 16.0 * int(picked_up), 0.25)
	$Item.offset.y = offset - height
	var shadow_scale = 1.0 - height / 48.0
	$Shadow.scale = Vector2(shadow_scale, shadow_scale)


func _on_interact() -> void:
	if player.item_carrying:
		player.item_carrying.pick_up()
	pick_up()


func pick_up() -> void:
	area.monitoring = picked_up
	picked_up = !picked_up
	player.item_carrying = self if picked_up else null
