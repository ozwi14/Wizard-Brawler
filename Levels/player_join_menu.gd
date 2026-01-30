extends Control

# Get connected devices (Controllers)
# Have a list of players -> controller
# The user uses mouse to progress to next scene

@export var player_boxes: Array[PlayerSelectionBox]


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	var players_ready : bool = _are_all_players_ready();
	if players_ready:
		# Store player data
		# Load next scene
		return
	
	

func _allow_waiting_for_next_player() -> void:
	for player_box in player_boxes:
		if not player_box.enabled:
			player_box.enabled = true
	pass

func _are_all_players_ready() -> bool:
	for player_box in player_boxes:
		if player_box.enabled and not player_box.player_is_ready:
			return false
	return true
