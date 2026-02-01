class_name PlayerUpgradeMenu extends Control

@export var all_magic_upgrades : Array[SpellItemData]

@export var upgrade_cards : Array[UpgradeSpellSlot]
var upgrades_to_choose: Array[SpellItemData]

var players : Array[PlayerData] = GameManager.players
var player_states : Array[PlayerState]

@onready var player_1_upgrade_selection: SpellChainSelectionBox = $"VBoxContainer/Top/Player 1 Upgrade Selection"
@onready var player_2_upgrade_selection: SpellChainSelectionBox = $"VBoxContainer/Top/Player 2 Upgrade Selection"
@onready var player_3_upgrade_selection: SpellChainSelectionBox = $"VBoxContainer/Bottom/Player 3 Upgrade Selection"
@onready var player_4_upgrade_selection: SpellChainSelectionBox = $"VBoxContainer/Bottom/Player 4 Upgrade Selection"

@export var card_amount: int = 5

@export var next_level : PackedScene

var player_1_upgrade_index : int = 0
var player_2_upgrade_index : int = 0
var player_3_upgrade_index : int = 0
var player_4_upgrade_index : int = 0

enum PlayerState {
	SelectingUpgrade,
	ApplyingUpgrade,
	Ready,
}

func _ready() -> void:
	if players.size() > 0:
		player_1_upgrade_selection.player_data = players[0]
		player_1_upgrade_selection.enabled = false
		player_1_upgrade_selection.set_static_images()
		player_states.append(PlayerState.SelectingUpgrade)
	if players.size() > 1:
		player_2_upgrade_selection.player_data = players[1]
		player_2_upgrade_selection.enabled = false
		player_2_upgrade_selection.set_static_images()
		player_states.append(PlayerState.SelectingUpgrade)
	if players.size() > 2:
		player_3_upgrade_selection.player_data = players[2]
		player_3_upgrade_selection.enabled = false
		player_3_upgrade_selection.set_static_images()
		player_states.append(PlayerState.SelectingUpgrade)
	if players.size() > 3:
		player_4_upgrade_selection.player_data = players[3]
		player_4_upgrade_selection.enabled = false
		player_4_upgrade_selection.set_static_images()
		player_states.append(PlayerState.SelectingUpgrade)
	
	_select_upgrades(card_amount)
	
	GameManager.PlayerFinishedUpgrading.connect(_on_player_finsihed_upgrading)

func _left_index(index : int) -> int:
	index -= 1
	if index < 0:
		index = 4
	return index

func _right_index(index : int) -> int:
	index += 1
	if index > 4:
		index = 0
	return index

func _input(event: InputEvent) -> void:
	var player_id = _find_player_id(event.device)
	if player_id == -1:
		return
	
	var current_state : PlayerState = player_states[player_id - 1]
	if current_state != PlayerState.SelectingUpgrade:
		return

	if player_id == 1:
		if event.is_action_pressed("ui_left"):
			player_1_upgrade_index = _left_index(player_1_upgrade_index)
		if event.is_action_pressed("ui_right"):
			player_1_upgrade_index = _right_index(player_1_upgrade_index)
		if event.is_action_pressed("action_start"):
			player_states[player_id - 1] = PlayerState.ApplyingUpgrade
			player_1_upgrade_selection.chain_user_selected = upgrades_to_choose[player_1_upgrade_index]
			player_1_upgrade_selection.enabled = true
	
	if player_id == 2:
		if event.is_action_pressed("ui_left"):
			player_2_upgrade_index = _left_index(player_2_upgrade_index)
		if event.is_action_pressed("ui_right"):
			player_2_upgrade_index = _right_index(player_2_upgrade_index)
		if event.is_action_pressed("action_start"):
			player_states[player_id - 1] = PlayerState.ApplyingUpgrade
			player_2_upgrade_selection.chain_user_selected = upgrades_to_choose[player_2_upgrade_index]
			player_2_upgrade_selection.enabled = true
			
	if player_id == 3:
		if event.is_action_pressed("ui_left"):
			player_3_upgrade_index = _left_index(player_3_upgrade_index)
		if event.is_action_pressed("ui_right"):
			player_3_upgrade_index = _right_index(player_3_upgrade_index)
		if event.is_action_pressed("action_start"):
			player_states[player_id - 1] = PlayerState.ApplyingUpgrade
			player_3_upgrade_selection.chain_user_selected = upgrades_to_choose[player_3_upgrade_index]
			player_3_upgrade_selection.enabled = true
			
	if player_id == 4:
		if event.is_action_pressed("ui_left"):
			player_4_upgrade_index = _left_index(player_4_upgrade_index)
		if event.is_action_pressed("ui_right"):
			player_4_upgrade_index = _right_index(player_4_upgrade_index)
		if event.is_action_pressed("action_start"):
			player_states[player_id - 1] = PlayerState.ApplyingUpgrade
			player_4_upgrade_selection.chain_user_selected = upgrades_to_choose[player_4_upgrade_index]
			player_4_upgrade_selection.enabled = true
	select_upgrade_slot()

var players_ready : int = 0

func _on_player_finsihed_upgrading() -> void:
	players_ready += 1
	
	if players_ready == players.size():
		print("Load next level")
		get_tree().change_scene_to_packed(next_level)

func select_upgrade_slot() -> void:
	var index : int = -1
	for upgrade_card in upgrade_cards:
		index += 1
		upgrade_card.player_1_selected = player_1_upgrade_index == index
		upgrade_card.player_2_selected = player_2_upgrade_index == index
		upgrade_card.player_3_selected = player_3_upgrade_index == index
		upgrade_card.player_4_selected = player_4_upgrade_index == index

func _find_player_id(device_id: int) -> int:
	for player in players:
		if player.device_id == device_id:
			return player.player_id
	return -1

func _all_players_selected_upgrade() -> void:
	if players.size() > 0:
		player_1_upgrade_selection.enabled = true
	if players.size() > 1:
		player_2_upgrade_selection.enabled = true
	if players.size() > 2:
		player_3_upgrade_selection.enabled = true
	if players.size() > 3:
		player_4_upgrade_selection.enabled = true

func _select_upgrades(amount: int) -> void:
	upgrades_to_choose = all_magic_upgrades.duplicate()
	upgrades_to_choose.shuffle()

	upgrades_to_choose = upgrades_to_choose.slice(0, amount)
	
	var index : int = -1
	for upgrade_to_choose in upgrades_to_choose:
		index += 1
		upgrade_cards[index].texture_rect.texture = upgrade_to_choose.icon_middle
