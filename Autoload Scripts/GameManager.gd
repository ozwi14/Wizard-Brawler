extends Node

var players : Array[PlayerData]

var devices_mapped : Array[int]

signal DeviceLinkedToPlayer
signal PlayerReady
signal playerDied

func add_players(player: PlayerData) -> void:
	players.append(player)
