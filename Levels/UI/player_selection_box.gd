class_name PlayerSelectionBox extends Control

var player_id : int
var device_id : int

var looking_for_player : bool = false
var player_found : bool = false

var player_is_ready: bool = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if player_is_ready:
		return
	
	if looking_for_player:
		_check_for_player()
		return
	
	if player_found:
		_check_for_ready()
		return

func _input(event):
	if event.is_action_pressed("ui_start"):
		print("Start pressed by controller:", event.device)

func _check_for_player() -> void:
	pass

func _check_for_ready() -> void:
	pass
