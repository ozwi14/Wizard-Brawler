class_name PlayerSpawner extends Node2D

@export var spawn_points: Array[Node2D]
@export var player_scene: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	assert(spawn_points.size() >= GameManager.players.size())
	pass # Replace with function body.

func spawn_players() -> void:
	print("Spawnning Players")
	var index = 0
	for player_data in GameManager.players:
		var player: Player = player_scene.instantiate()
		player.player_data = player_data
		player.position = spawn_points[index].position
		get_tree().current_scene.add_child(player)
		index += 1
