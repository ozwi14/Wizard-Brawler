class_name PlayerSelectionBox extends Control

var player_id : int
var device_id : int

var looking_for_device : bool = false
var waiting_for_player_ready : bool = false

var player_is_ready: bool = false

var ready_time_required : float = 3.0
var ready_time_held : float = 0.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if player_is_ready:
		return
	
	if waiting_for_player_ready:
		_check_for_ready(delta)
		return

func _input(event):
	if looking_for_device:
		if event.is_action_pressed("ui_accept"):
			print("Start pressed by controller:", event.device)
			device_id = event.device
			looking_for_device = false
			waiting_for_player_ready = true

func _check_for_ready(delta: float) -> void:
	if Input.is_joy_button_pressed(device_id, JOY_BUTTON_START):
		ready_time_held += delta
		
		if ready_time_held >= ready_time_required:
			waiting_for_player_ready = false
			player_is_ready = true
	else:
		ready_time_held = 0.0
	
