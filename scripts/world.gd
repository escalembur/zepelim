extends TileMapLayer

@export var noise_texture: NoiseTexture2D

var noise: Noise

var width := 625
var height := 625

var source_id = 0
var water_atlas = Vector2i(2, 0)
var land_atlas = Vector2i(1, 3)

func _ready() -> void:
	noise = noise_texture.noise
	generate_world()


func generate_world() -> void:
	for x in range(width):
		for y in range(height):
			var noise_val = noise.get_noise_2d(x,y)
			if noise_val > 0.0:
				# place land
				set_cell(Vector2(x, y), source_id, land_atlas)
