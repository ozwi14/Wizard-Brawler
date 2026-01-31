extends Light2D

@export var base_energy := 1.2
@export var flicker_strength := 0.25
@export var flicker_speed := 8.0

@export var warm_color := Color(1.0, 0.85, 0.6)
@export var cool_color := Color(1.0, 0.75, 0.5)

var noise := FastNoiseLite.new()
var time := 0.0
var time_offset := 0.0

func _ready():
	noise.noise_type = FastNoiseLite.TYPE_SIMPLEX
	noise.frequency = 1.0
	# Random offset for independent flicker per candle
	time_offset = randf() * 100.0

func _process(delta):
	time += delta * flicker_speed

	# Use the per-candle offset
	var n := noise.get_noise_1d(time + time_offset)

	# Flicker brightness
	energy = base_energy + n * flicker_strength

	# Flicker color
	color = warm_color.lerp(cool_color, (n + 1.0) * 0.5)
