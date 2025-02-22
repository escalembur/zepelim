extends Node2D

@onready var area: InteractionArea = $Interact
@onready var particles : GPUParticles2D = $GPUParticles2D

func _ready() -> void:
	area.interact = Callable(self, "_on_interact")

func _on_interact() -> void:
	particles.emitting = false
	area.monitoring = false
	await get_tree().create_timer(1.0).timeout
	queue_free()
