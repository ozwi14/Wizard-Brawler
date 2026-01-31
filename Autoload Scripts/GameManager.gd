extends Node

var players : Array[PlayerData]

var devices_mapped : Array[int]
var possible_spells : Array[SpellSelectionDataWrapper]

signal DeviceLinkedToPlayer
signal PlayerReady

func add_players(player: PlayerData) -> void:
	players.append(player)
