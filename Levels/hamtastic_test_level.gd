extends Node2D

#setting the player variables here for testing (Because we have 2 and this was the best way i could think for them to
#inherit the same values

@onready var player_spawner: PlayerSpawner = $PlayerSpawner
var players_dead : int = 0



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player_spawner.spawn_players()
	GameManager.playerDied.connect(_onplayerdeath)
	
	pass # Replace with function body.
	
func _onplayerdeath() -> void:
	var total_players = GameManager.players.size()
	players_dead +=1
	if players_dead >= total_players-1:
		print("trumpets")
	

	
