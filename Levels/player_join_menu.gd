extends Control

# Get connected devices (Controllers)
# Have a list of players -> controller

@export var player_boxes: Array[PlayerSelectionBox]

@export var next_level : PackedScene


var players_joined: int = 0
var players_ready: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player_boxes[0].StartWaitingForDevice()
	
	GameManager.DeviceLinkedToPlayer.connect(_on_device_linked)
	GameManager.PlayerReady.connect(_on_player_ready)
	
	var player_number : int = 0
	for player_box in player_boxes:
		player_number += 1
		player_box.SetPlayerId(player_number)
		pass
	pass

func _on_device_linked() -> void:
	players_joined += 1
	
	var enabled_next_player_selection : bool = false
	for player_box in player_boxes:
		if player_box.player_state == player_box.PlayerSelectionState.DeviceFound:
			enabled_next_player_selection = true
			continue
		
		if enabled_next_player_selection:
			player_box.StartWaitingForDevice()
			return
	pass

func _on_player_ready() -> void:
	players_ready += 1
	
	print("Players Joined ", players_joined)
	print("Players Ready  ", players_ready)
	
	if players_ready == players_joined and players_ready >= 2:
		for player_box in player_boxes:
			if player_box.player_state == PlayerSelectionBox.PlayerSelectionState.PlayerReady:
				var player: PlayerData = PlayerData.new()
				player.player_id = player_box.player_id
				player.device_id = player_box.device_id
				
				GameManager.add_players(player)
		
		# Load next scene
		print("Load next level")
		get_tree().change_scene_to_packed(next_level)
