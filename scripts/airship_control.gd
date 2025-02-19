extends Node

@onready var airship := Global.airship
@onready var player := Global.player
@onready var area: InteractionArea = $InteractionArea


func _ready():
	area.interact = Callable(self, "_on_interact")

func _on_interact() -> void:
	# Toggle between player movement and airship movement
	player.can_move = !player.can_move
	airship.controlling = !airship.controlling
