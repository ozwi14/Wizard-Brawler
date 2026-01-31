class_name PlayerSpawner extends Node2D

@export var spawn_points: Array[Node2D]
@export var player_scene: PackedScene 

@export var debug_spawn_players : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if debug_spawn_players:
		return
	assert(spawn_points.size() >= GameManager.players.size())
	assert(player_scene != null)
	pass # Replace with function body.

func spawn_players() -> void:
	print("Spawnning Players")
	if debug_spawn_players:
		print("Debug spawning players with fake data")
		GameManager.players.clear()
		var player1 := PlayerData.new()
		var player2 := PlayerData.new()
		player1.device_id = 0
		player1.player_id = 1
		player2.device_id = 1
		player2.player_id = 2
		GameManager.players.append(player1)
		GameManager.players.append(player2)
	
	var index = 0
	for player_data in GameManager.players:
		var player = player_scene.instantiate()
		player.player_data = player_data
		player.position = spawn_points[index].position
		get_tree().current_scene.add_child(player)
		index += 1
