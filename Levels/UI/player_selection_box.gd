class_name PlayerSelectionBox extends Control

var player_id : int
var device_id : int

enum PlayerSelectionState {
	Disabled,
	LookingForDevice,
	DeviceFound,
	PlayerReady,
}

@export var player_state : PlayerSelectionState = PlayerSelectionState.Disabled
@export var ready_time_required : float = 0.5
@onready var progress_bar: ProgressBar = $VBoxContainer/ProgressBar

var ready_time_held : float = 0.0

func _ready() -> void:
	var devices = Input.get_connected_joypads()
	print("Device Ids: ", devices)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if player_state == PlayerSelectionState.PlayerReady:
		return
	
	if player_state == PlayerSelectionState.DeviceFound:
		_check_for_ready(delta)
		return

func _input(event):
	#print("Controller %d pressed a button", event.device)
	if player_state == PlayerSelectionState.LookingForDevice:
		var local_device_id = event.device
		if GameManager.devices_mapped.find(local_device_id) != -1:
			return
		
		if event.is_action_pressed("action_start"):
			print("Start pressed by controller:", local_device_id)
			device_id = event.device
			Input.start_joy_vibration(device_id, 1, 0, 0.5)
			player_state = PlayerSelectionState.DeviceFound
			GameManager.DeviceLinkedToPlayer.emit()
			GameManager.devices_mapped.append(device_id)
			$"VBoxContainer/Player Action Request".text = "Hold Start to ready up"

func _check_for_ready(delta: float) -> void:
	if Input.is_joy_button_pressed(device_id, JOY_BUTTON_START):
		ready_time_held += delta
		
		progress_bar.value += delta
		
		print("Time held: ", ready_time_held)
		
		if ready_time_held >= ready_time_required:
			player_state = PlayerSelectionState.PlayerReady
			GameManager.PlayerReady.emit()
			$"VBoxContainer/Player Action Request".text = "I'm Ready"
	else:
		ready_time_held = 0.0
		progress_bar.value = 0

func StartWaitingForDevice() -> void:
	player_state = PlayerSelectionState.LookingForDevice
	$"VBoxContainer/Player Action Request".text = "Press Start Join"
	pass

func SetPlayerId(player_number : int) -> void:
	player_id = player_number
	$"VBoxContainer/Player Name Label".text = "Player %d" % player_id
