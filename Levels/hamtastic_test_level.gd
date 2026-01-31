extends Node2D

#setting the player variables here for testing (Because we have 2 and this was the best way i could think for them to
#inherit the same values

@onready var player_spawner: PlayerSpawner = $PlayerSpawner


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player_spawner.spawn_players()
	pass # Replace with function body.
