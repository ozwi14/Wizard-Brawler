extends Node

var players : Array[PlayerData]

var devices_mapped : Array[int]

func add_players(player_id: int, device_id: int) -> void:
	var player: PlayerData
	player.player_id = player_id
	player.device_id = device_id
	
	players.append(player)
