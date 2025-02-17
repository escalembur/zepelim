extends Node


var interact_parent: Interact

@onready var airship := %Airship
@onready var player := %Player


func _ready() -> void:
	# Connect to parent interact component
	interact_parent = get_parent()
	interact_parent.interacted.connect(_on_interact)


func _on_interact() -> void:
	# Toggle between player movement and airship movement
	player.can_move = !player.can_move
	airship.controlling = !airship.controlling
