extends Control

# Get connected devices (Controllers)
# Have a list of players -> controller
# The user uses mouse to progress to next scene

@export var player_boxes: Array[PlayerSelectionBox]

var all_players_ready: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player_boxes[0].player_state = PlayerSelectionBox.PlayerSelectionState.LookingForDevice
	pass



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if all_players_ready:
		print("All Players ready, load next Scene")
		# Store player data
		# Load next scene
		return
		
	all_players_ready = _are_all_players_ready();
	
	_allow_waiting_for_next_player()
	

func _allow_waiting_for_next_player() -> void:
	var enabled_next_player_selection : bool = false
	for player_box in player_boxes:
		if player_box.player_state == player_box.PlayerSelectionState.DeviceFound:
			enabled_next_player_selection = true
			continue
		
		if enabled_next_player_selection:
			player_box.player_state = player_box.PlayerSelectionState.LookingForDevice
			return
	pass

# Think about replacing this with signals
func _are_all_players_ready() -> bool:
	var players_ready: int = 0
	for player_box in player_boxes:
		if player_box.player_state == PlayerSelectionBox.PlayerSelectionState.Disabled:
			print("Player disabled skip")
			continue
		if player_box.player_state == PlayerSelectionBox.PlayerSelectionState.DeviceFound:
			print("Player found, but not ready")
			return false
		if player_box.player_state == PlayerSelectionBox.PlayerSelectionState.PlayerReady:
			players_ready += 1
	
	return players_ready > 0
